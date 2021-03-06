//
//  QuestionUpdateManager.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateController.h"
#import "ServerComms.h"
#import "ServerConstants.h"
#import "PendingUpdateParser.h"
#import "ServerResponse.h"
#import "UpdateUrlBuilder.h"
#import "UpdateFetcher.h"
#import <MagicalRecord/MagicalRecord.h>
#import "PendingUpdateModel.h"
#import "QuestionUpdateParser.h"
#import "AnswerUpdateParser.h"

@implementation UpdateController

-(void)checkForNewUpdatesOnServer:(void(^)(ServerResponse *response))callBack
{    
    // NSDate last update time
    NSString *lastUpdateTimeInEpoch = @"12345"; //Fixme: this is ignored on server at the moment it passes back everything each time
    NSString *updateUrl = [NSString stringWithFormat:@"%@%@%@", [ServerConstants getCurrentBaseUrl], kServerEndPointUpdatesSince, lastUpdateTimeInEpoch];
    NSMutableArray *updateUrlArray = [[NSMutableArray alloc]init];
    [updateUrlArray addObject:updateUrl];
    
    UpdateFetcher *updateFetcher = [[UpdateFetcher alloc]init];
    [updateFetcher fetchUrls:updateUrlArray usingParser:[PendingUpdateParser class] complete:^(ServerResponse *response){
        callBack(response);
    }];
}

-(void)checkForPendingUpdatesOnClient:(void(^)(ServerResponse *response))callBack
{
    NSString *baseUrl = [ServerConstants getCurrentBaseUrl];
    
    NSMutableArray *pendingQuestionUpdates = [self generateUpdateUrlsForModelType:kServerModelTypeQuestion withBaseUrl:baseUrl];
    NSMutableArray *pendingAnswerUpdates   = [self generateUpdateUrlsForModelType:kServerModelTypeAnswer withBaseUrl:baseUrl];
    
    // Note: we need to make sure questionUpdates are proccessed before answerUpdates so we can connect the relationships -
    // when we get the response
    
    UpdateFetcher *updateFetcher = [[UpdateFetcher alloc]init];
    
    if (pendingQuestionUpdates.count > 0) {
        [updateFetcher fetchUrls:pendingQuestionUpdates usingParser:[QuestionUpdateParser class] complete:^(ServerResponse *response){
            [updateFetcher fetchUrls:pendingAnswerUpdates usingParser:[AnswerUpdateParser class] complete:^(ServerResponse *response){
                callBack(response);
            }];
        }];
    } else if (pendingAnswerUpdates.count > 0) {
        [updateFetcher fetchUrls:pendingAnswerUpdates usingParser:[AnswerUpdateParser class] complete:^(ServerResponse *response){
            callBack(response);
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
