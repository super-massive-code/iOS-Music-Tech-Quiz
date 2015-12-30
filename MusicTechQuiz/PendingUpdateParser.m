//
//  UpdateParser.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "PendingUpdateParser.h"
#import "ServerConstants.h"
#import "PendingUpdate.h"

@implementation PendingUpdateParser

+(void)parseUpdateResponse:(NSDictionary *)updateDict
{
    NSArray *answerUpdates   = [updateDict objectForKey:kServerModelTypeAnswer];
    NSArray *questionUpdates = [updateDict objectForKey:kServerModelTypeQuestion];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    for (NSNumber *remoteObjId in answerUpdates) {
        PendingUpdate *newUpdate = [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeAnswer];
        [realm addObject:newUpdate];
    }
    
    for (NSNumber *remoteObjId in questionUpdates) {
        PendingUpdate *newUpdate = [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeQuestion];
        [realm addObject:newUpdate];
    }
    
    [realm commitWriteTransaction];
}

+(PendingUpdate*)createUpdateObjectForRemoteId:(NSNumber*)remoteId andModelType:(NSString*)modelType
{
    PendingUpdate *newUpdate = [[PendingUpdate alloc]init];
    newUpdate.created = [NSDate date];
    newUpdate.modelType = modelType;
    newUpdate.remoteId = remoteId;
    
    return newUpdate;
}

@end
