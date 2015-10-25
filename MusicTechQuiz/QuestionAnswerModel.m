//
//  QuestionAnswerModel.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerModel.h"

@interface QuestionAnswerModel ()

@property (nonatomic, copy, readwrite) NSArray *answers;

@property (nonatomic, copy, readwrite) NSString *question;
@property (nonatomic, copy, readwrite) NSString *correctAnswer;

@end

@implementation QuestionAnswerModel

-(instancetype)initWithQuestion:(NSString*)question answers:(NSArray*)answers correctAnswer:(NSString*)correctAnswer;
{
    self = [super init];
    if (self) {
        self.answers = answers;
        self.question = question;
        self.correctAnswer = correctAnswer;
    }
    
    return self;
}

@end
