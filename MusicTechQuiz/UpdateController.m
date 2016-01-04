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

-(void)checkForNewUpdatesOnServer:(void(^)(void))callBack
{
    // NSDate last update time
    NSString *lastUpdateTimeInEpoch = @"12345"; //Fixme: this is ignored on server at the moment
    NSString *updateUrl = [NSString stringWithFormat:@"%@%@%@", [ServerComms getCurrentBaseUrl], kServerEndPointUpdatesSince, lastUpdateTimeInEpoch];
    NSMutableArray *updateUrlArray = [[NSMutableArray alloc]init];
    [updateUrlArray addObject:updateUrl];
    
    UpdateFetcher *updateFetcher = [[UpdateFetcher alloc]init];
    [updateFetcher fetchUrls:updateUrlArray usingParser:[PendingUpdateParser class] complete:^{
        callBack();
    }];
}

-(void)checkForPendingUpdatesOnClient:(void(^)(void))callBack
{
    NSString *baseUrl = [ServerComms getCurrentBaseUrl];
    
    NSMutableArray *pendingQuestionUpdates = [self generateUpdateUrlsForModelType:kServerModelTypeQuestion withBaseUrl:baseUrl];
    NSMutableArray *pendingAnswerUpdates   = [self generateUpdateUrlsForModelType:kServerModelTypeAnswer withBaseUrl:baseUrl];
    
    // Note: we need to make sure questionUpdates are proccessed before answerUpdates so we can connect the relationships -
    // when we get the response
    
    UpdateFetcher *updateFetcher = [[UpdateFetcher alloc]init];
    
    if (pendingQuestionUpdates.count > 0) {
        [updateFetcher fetchUrls:pendingQuestionUpdates usingParser:[QuestionUpdateParser class] complete:^{
            [updateFetcher fetchUrls:pendingAnswerUpdates usingParser:[AnswerUpdateParser class] complete:^{
                callBack();
            }];
        }];
    } else if (pendingAnswerUpdates.count > 0) {
        [updateFetcher fetchUrls:pendingAnswerUpdates usingParser:[AnswerUpdateParser class] complete:^{
            callBack();
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
