//
//  UpdateParser.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "PendingUpdateParser.h"
#import "ServerConstants.h"
#import "PendingUpdateModel.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation PendingUpdateParser

+(void)parseUpdateResponse:(NSDictionary *)updateDict inContext:(NSManagedObjectContext*)moc
{
    NSArray *questionUpdates = [updateDict objectForKey:kServerModelTypeQuestion];
    NSArray *answerUpdates   = [updateDict objectForKey:kServerModelTypeAnswer];
    
    for (NSNumber *remoteObjId in questionUpdates) {
        [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeQuestion inMoc:moc];
    }
    
    for (NSNumber *remoteObjId in answerUpdates) {
        [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeAnswer inMoc:moc];
    }
}

+(void)createUpdateObjectForRemoteId:(NSNumber*)remoteId andModelType:(NSString*)modelType inMoc:(NSManagedObjectContext*)moc
{
    [self deleteUpdateObjectForRemoteId:remoteId andModelType:modelType inMoc:moc];
    
    PendingUpdateModel *update = [PendingUpdateModel MR_createEntityInContext:moc];
    update.created   = [NSDate date];
    update.modelType = modelType;
    update.remoteId  = remoteId;
}

+(void)deleteUpdateObjectForRemoteId:(NSNumber*)remoteId andModelType:(NSString*)modelType inMoc:(NSManagedObjectContext*)moc
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remoteId == %@ AND modelType ==[c] %@", remoteId, modelType];
    PendingUpdateModel *update = [PendingUpdateModel MR_findFirstWithPredicate:predicate inContext:moc];
    [update MR_deleteEntityInContext:moc];
}

@end