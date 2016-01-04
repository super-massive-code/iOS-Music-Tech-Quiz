//
//  QuestionController.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionController.h"
#import "QuestionAnswerCompModel.h"
#import "QuestionModel.h"
#import "AnswerModel.h"
#import <MagicalRecord/MagicalRecord.h>

@interface QuestionController ()

@property (nonatomic, strong) NSMutableArray *allQuestions;
@property NSInteger currentIndex;

@end

@implementation QuestionController

-(QuestionAnswerCompModel*)loadNextQuestion
{
    if (self.allQuestions == nil) {
        self.allQuestions = [self loadQuestionFromStore];
    }
    
    if (self.allQuestions.count > 0) {
        QuestionAnswerCompModel *model = [self.allQuestions objectAtIndex:0];
        [self.allQuestions removeObjectAtIndex:0];
        return model;
    } else {
        return nil;
    }
}

-(NSMutableArray*)loadQuestionFromStore
{
    NSMutableArray *compositeModelsArray = [[NSMutableArray alloc]init];
    
    NSArray *questions = [QuestionModel MR_findAll];
    for (QuestionModel *question in questions) {
        QuestionAnswerCompModel *compModel = [self createCompositeModelFromQuestion:question];
        if (compModel) {
            [compositeModelsArray addObject:compModel];
        }
    }
    
    return compositeModelsArray;
}

-(QuestionAnswerCompModel*)createCompositeModelFromQuestion:(QuestionModel*)question
{
    NSString *correctAnswer;
    
    NSMutableArray *answers = [[NSMutableArray alloc]init];
    for (AnswerModel *answer in question.answers) {
        [answers addObject:answer.title];
        if (answer.isCorrectAnswer.boolValue) {
            correctAnswer = answer.title;
        }
    }
    
    if (correctAnswer) {
        // Protect against server validation going wrong
        QuestionAnswerCompModel *model = [[QuestionAnswerCompModel alloc]initWithQuestion:question.title answers:answers correctAnswer:correctAnswer];
        return model;
    } else {
        return nil;
    }
}

@end
