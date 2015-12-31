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

+(void)parseUpdateResponse:(NSDictionary *)updateDict
{
    NSArray *answerUpdates   = [updateDict objectForKey:kServerModelTypeAnswer];
    NSArray *questionUpdates = [updateDict objectForKey:kServerModelTypeQuestion];
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        for (NSNumber *remoteObjId in answerUpdates) {
            [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeAnswer];
        }
        
        for (NSNumber *remoteObjId in questionUpdates) {
            [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeQuestion];
        }
        [localContext save:nil];
    }];
}

+(void)createUpdateObjectForRemoteId:(NSNumber*)remoteId andModelType:(NSString*)modelType
{
    PendingUpdateModel *newUpdate = [PendingUpdateModel MR_createEntity];
    
    newUpdate.created   = [NSDate date];
    newUpdate.modelType = modelType;
    newUpdate.remoteId  = remoteId;
}

@end
