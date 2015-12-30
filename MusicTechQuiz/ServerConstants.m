//
//  ServerConstants.m
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "ServerConstants.h"

@implementation ServerConstants

NSString * const kServerBaseUrlProduction               = @"https://carltaylor43.pythonanywhere.com/";
NSString * const kServerBaseUrlLocal                    = @"http://127.0.0.1:8000/";
NSString * const kServerEndPointLoginUser               = @"login_user";
NSString * const kServerEndPointUpdatesSince            = @"updates_since/";
NSString * const kServerEndPointGetQuestion             = @"question/";
NSString * const kServerEndPointGetAnswer               = @"answer/";
NSString * const kServerEndPointAddQuestionWithAnswers  = @"add_question_with_answers";

@end
