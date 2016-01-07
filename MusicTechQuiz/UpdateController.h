//
//  QuestionUpdateManager.h
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServerResponse;

@interface UpdateController : NSObject

-(void)checkForNewUpdatesOnServer:(void(^)(ServerResponse *response))callBack;
-(void)checkForPendingUpdatesOnClient:(void(^)(ServerResponse *response))callBack;

@end
