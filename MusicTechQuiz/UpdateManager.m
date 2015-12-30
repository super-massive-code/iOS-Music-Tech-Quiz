//
//  QuestionUpdateManager.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateManager.h"
#import "ServerComms.h"
#import "RealmModels.h"
#import "ServerConstants.h"
#import "PendingUpdateParser.h"
#import "ServerResponse.h"
#import "PendingUpdate.h"
#import "UpdateUrlBuilder.h"
#import "UpdateFetcher.h"

@implementation UpdateManager

-(void)checkForUpdatesOnServer
{
    // NSDate last update time
    NSString *lastUpdateTimeInEpoch = @"12345"; //Fixme: this is ignored on server at the moment
    NSString *updateUrl = [NSString stringWithFormat:@"%@%@%@", [ServerComms getCurrentBaseUrl], kServerEndPointUpdatesSince, lastUpdateTimeInEpoch];
    
    ServerComms *comms = [[ServerComms alloc]init];
    [comms getJSONfromUrl:updateUrl callCallBack:^(ServerResponse *responseObject) {
        if (responseObject.connectionMade && responseObject.responseDict && !responseObject.error) {
            [PendingUpdateParser parseUpdateResponse:responseObject.responseDict];
        } else {
            //todo: handle error
        }
    }];
}

-(void)checkForUpdatesOnClient
{
    NSMutableArray *updateUrls = [[NSMutableArray alloc]init];
    NSString *baseUrl = [ServerComms getCurrentBaseUrl];
    
    RLMResults<PendingUpdate*> *questionUpdates = [PendingUpdate objectsWhere:[NSString stringWithFormat:@"modelType == '%@'", kServerModelTypeQuestion]];
    RLMResults<PendingUpdate*> *answerUpdates   = [PendingUpdate objectsWhere:[NSString stringWithFormat:@"modelType == '%@'", kServerModelTypeAnswer]];
    
    //Note: we need to make sure questionUpdates are proccessed before answer updates so we can connect the relationships -
    // when we get the response. So add them to the updateUrls array in this order
    for (PendingUpdate *update in questionUpdates) {
        NSString *updateUrl = [UpdateUrlBuilder buildUrlFromModel:update andBaseUrl:baseUrl];
        [updateUrls addObject:updateUrl];
    }
    
    for (PendingUpdate *update in answerUpdates) {
        NSString *updateUrl = [UpdateUrlBuilder buildUrlFromModel:update andBaseUrl:baseUrl];
        [updateUrls addObject:updateUrl];
    }
    
    if (updateUrls.count > 0) {
        UpdateFetcher *updateFetcher = [[UpdateFetcher alloc]init];
        [updateFetcher fetchUrls:updateUrls];
    }  
}

@end
