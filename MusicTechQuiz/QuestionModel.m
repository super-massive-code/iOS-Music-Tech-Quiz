//
//  QuestionAnswerModel.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionModel.h"

@interface QuestionModel ()

@property (nonatomic, readwrite) NSNumber *remoteDatabaseId;

@property (nonatomic, copy, readwrite) NSArray *answers;

@property (nonatomic, copy, readwrite) NSString *question;
@property (nonatomic, copy, readwrite) NSString *correctAnswer;

@end

@implementation QuestionModel

-(instancetype)initWithQuestion:(NSString*)question
                        answers:(NSArray*)answers
                  correctAnswer:(NSString*)correctAnswer
               remoteDatabaseId:(NSNumber*)remoteDatabaseId
{
    self = [super init];
    if (self) {
        self.answers = answers;
        self.question = question;
        self.correctAnswer = correctAnswer;
        self.remoteDatabaseId = remoteDatabaseId;
    }
    
    return self;
}

-(NSString*)description
{
    NSString *desc = [NSString stringWithFormat:@"Question: %@\nAnswers: %@\nCorrect Answer: %@\nRemote Database Id: %@", self.question, self.answers, self.correctAnswer, self.remoteDatabaseId];
    return desc;
}

@end
