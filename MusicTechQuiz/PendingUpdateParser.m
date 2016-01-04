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
    NSArray *answerUpdates   = [updateDict objectForKey:kServerModelTypeAnswer];
    NSArray *questionUpdates = [updateDict objectForKey:kServerModelTypeQuestion];

        for (NSNumber *remoteObjId in answerUpdates) {
            [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeAnswer inMoc:moc];
        }
    
        for (NSNumber *remoteObjId in questionUpdates) {
            [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeQuestion inMoc:moc];
        }
}

+(void)createUpdateObjectForRemoteId:(NSNumber*)remoteId andModelType:(NSString*)modelType inMoc:(NSManagedObjectContext*)moc
{
    PendingUpdateModel *update = [PendingUpdateModel MR_findFirstByAttribute:@"remoteId" withValue:remoteId];
    
    if (update) {
        [update MR_deleteEntity];
        update = [PendingUpdateModel MR_createEntityInContext:moc];
    }
    
    update.created   = [NSDate date];
    update.modelType = modelType;
    update.remoteId  = remoteId;
    
    NSError *saveError;
    [moc save:&saveError];
}

+(void)deleteUpdateObjectForRemoteId:(NSNumber*)remoteId
{
    PendingUpdateModel *update = [PendingUpdateModel MR_findFirstByAttribute:@"remoteId" withValue:remoteId];
//    [update MR_deleteEntity];
}

@end
