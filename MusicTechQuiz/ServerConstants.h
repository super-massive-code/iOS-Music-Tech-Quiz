//
//  ServerConstants.h
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerConstants : NSObject

extern NSString * const kServerBaseUrl;
extern NSString * const kServerEndPointLogin;
extern NSString * const kServerEndPointUpdatesSince;
extern NSString * const kServerEndPointGetQuestion;
extern NSString * const kServerEndPointGetAnswer;
extern NSString * const kServerEndPointAddQuestionWithAnswers;

@end
