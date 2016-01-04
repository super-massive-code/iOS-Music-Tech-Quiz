//
//  QuestionUpdateManager.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateManager.h"
#import "ServerComms.h"
#import "ServerConstants.h"
#import "PendingUpdateParser.h"
#import "ServerResponse.h"
#import "UpdateUrlBuilder.h"
#import "UpdateFetcher.h"
#import <MagicalRecord/MagicalRecord.h>
#import "PendingUpdateModel.h"
#import "QuestionAnswerUpdateParser.h"

@implementation UpdateManager

-(void)checkForNewUpdatesOnServer:(void(^)(void))callBack
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
        callBack();
    }];
}

-(void)checkForPendingUpdatesOnClient
{
    NSString *baseUrl = [ServerComms getCurrentBaseUrl];
    
    NSMutableArray *questionUpdates = [self generateUpdateUrlsForModelType:kServerModelTypeQuestion withBaseUrl:baseUrl];
    NSMutableArray *answerUpdates   = [self generateUpdateUrlsForModelType:kServerModelTypeAnswer withBaseUrl:baseUrl];
    
    // Note: we need to make sure questionUpdates are proccessed before answerUpdates so we can connect the relationships -
    // when we get the response
    
    if (questionUpdates.count > 0) {
        UpdateFetcher *updateFetcher = [[UpdateFetcher alloc]init];
        [updateFetcher fetchUrls:questionUpdates usingParser:[QuestionAnswerUpdateParser class] complete:^{
            
        }];    
    }
}

-(NSMutableArray*)generateUpdateUrlsForModelType:(NSString*)modelType withBaseUrl:(NSString*)baseUrl
{
     NSArray *modelUpdates = [PendingUpdateModel  MR_findByAttribute:@"modelType" withValue:modelType];
     NSMutableArray *updateUrls = [[NSMutableArray alloc]init];
    
    for (PendingUpdate *update in modelUpdates) {
        NSString *updateUrl = [UpdateUrlBuilder buildUrlFromModel:update andBaseUrl:baseUrl];
        [updateUrls addObject:updateUrl];
    }    
    return updateUrls;
}

@end
