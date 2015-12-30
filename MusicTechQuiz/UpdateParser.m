//
//  UpdateParser.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateParser.h"
#import "ServerConstants.h"
#import "Update.h"

@implementation UpdateParser

+(void)parseUpdateResponse:(NSDictionary *)updateDict
{
    NSArray *answerUpdates   = [updateDict objectForKey:kServerModelTypeAnswer];
    NSArray *questionUpdates = [updateDict objectForKey:kServerModelTypeQuestion];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    for (NSNumber *remoteObjId in answerUpdates) {
        Update *newUpdate = [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeAnswer];
        [realm addObject:newUpdate];
    }
    
    for (NSNumber *remoteObjId in questionUpdates) {
        Update *newUpdate = [self createUpdateObjectForRemoteId:remoteObjId andModelType:kServerModelTypeQuestion];
        [realm addObject:newUpdate];
    }
    
    [realm commitWriteTransaction];
}

+(Update*)createUpdateObjectForRemoteId:(NSNumber*)remoteId andModelType:(NSString*)modelType
{
    Update *newUpdate = [[Update alloc]init];
    newUpdate.created = [NSDate date];
    newUpdate.modelType = modelType;
    newUpdate.remote_id = remoteId;
    
    return newUpdate;
}

@end
