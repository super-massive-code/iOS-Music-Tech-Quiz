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

@implementation UpdateManager

+(void)checkForUpdates
{
    // NSDate last update time
    NSString *lastUpdateTimeInEpoch;
    NSString *updateUrl = [NSString stringWithFormat:@"%@%@%@", kServerBaseUrl, kServerEndPointUpdatesSince, lastUpdateTimeInEpoch];
    
    ServerComms *comms = [[ServerComms alloc]init];
    [comms getJSONfromUrl:updateUrl callCallBack:^(ServerResponse *responseObject) {
        
    }];
}

-(void)saveToStore
{
    // create questionStoreController
}

@end
