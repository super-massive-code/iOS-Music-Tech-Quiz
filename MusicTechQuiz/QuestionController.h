//
//  QuestionController.h
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionAnswerCompModel;

@interface QuestionController : NSObject

-(QuestionAnswerCompModel*)loadNextQuestion;
+(BOOL)doesHaveQuestionsInDatabase;

@end
