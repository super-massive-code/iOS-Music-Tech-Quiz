//
//  QuestionUpdateManager.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateManager.h"
#import "ServerComms.h"
#import "BaseRealmObj.h"
#import "ServerConstants.h"
#import "UpdateParser.h"
#import "ServerResponse.h"
#import "Update.h"
#import "UpdateUrlBuilder.h"
#import "UpdateQueue.h"

@implementation UpdateManager

+(void)checkForUpdatesOnServer
{
    // NSDate last update time
    NSString *lastUpdateTimeInEpoch = @"12345"; //Fixme: this is ignored on server at the moment
    NSString *updateUrl = [NSString stringWithFormat:@"%@%@%@", [ServerComms getCurrentBaseUrl], kServerEndPointUpdatesSince, lastUpdateTimeInEpoch];
    
    ServerComms *comms = [[ServerComms alloc]init];
    [comms getJSONfromUrl:updateUrl callCallBack:^(ServerResponse *responseObject) {
        if (responseObject.connectionMade && responseObject.responseDict && !responseObject.error) {
            [UpdateParser parseUpdateResponse:responseObject.responseDict];
        } else {
            //todo: handle error
        }
    }];
}

-(void)checkForUpdatesOnClient
{
    NSMutableArray *updateUrls = [[NSMutableArray alloc]init];
    
    RLMResults<Update*> *questionUpdates = [Update objectsWhere:[NSString stringWithFormat:@"modelType == '%@'", kServerModelTypeQuestion]];
    RLMResults<Update*> *answerUpdates   = [Update objectsWhere:[NSString stringWithFormat:@"modelType == '%@'", kServerModelTypeAnswer]];
    
    //Note: we need to make sure questionUpdates are proccessed before answer updates so we can connect the relationships -
    // when we get the response. So add them to the updateUrls array in this order
    for (Update *update in questionUpdates) {
        NSString *updateUrl = [UpdateUrlBuilder buildUrlFromModel:update andBaseUrl:kServerBaseUrlLocal];
        [updateUrls addObject:updateUrl];
    }
    
    for (Update *update in answerUpdates) {
        NSString *updateUrl = [UpdateUrlBuilder buildUrlFromModel:update andBaseUrl:kServerBaseUrlLocal];
        [updateUrls addObject:updateUrl];
    }
    
    UpdateQueue *updateQueue = [[UpdateQueue alloc]init];
    [updateQueue addUrlsToInMemoryQueue:updateUrls];
}

@end
