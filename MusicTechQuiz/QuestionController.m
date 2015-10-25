//
//  QuestionController.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionController.h"
#import "QuestionModel.h"

@interface QuestionController ()

@property (nonatomic, strong) NSMutableArray *allQuestions;
@property NSInteger currentIndex;

@end

@implementation QuestionController

-(QuestionModel*)loadNextQuestion
{
    if (self.allQuestions == nil) {
        self.allQuestions = [self loadQuestionFromStore];
    }
    
    if (self.allQuestions.count > 0) {
        QuestionModel *model = [self.allQuestions objectAtIndex:0];
        [self.allQuestions removeObjectAtIndex:0];
        return model;
    } else {
        return nil;
    }
}

-(NSMutableArray*)loadQuestionFromStore
{
    NSString *question = @"Name the Roland Acid Synth";
    NSArray *answers = @[@"TB 303", @"Jupiter 8", @"909"];
    
    QuestionModel *model = [[QuestionModel alloc]initWithQuestion:question answers:answers correctAnswer:@"TB 303" remoteDatabaseId:@91];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:model];
    
    // load from plist
    // randomise
    
    return array;
}

@end
