//
//  GameEngine.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "GameEngine.h"
#import "QuestionAnswerCompModel.h"
#import "QuestionController.h"

@import AVFoundation;

@interface GameEngine ()

@property (strong, nonatomic) QuestionAnswerCompModel *currentModel;
@property (strong, nonatomic) QuestionController *questionController;

@property (strong, nonatomic) AVAudioPlayer *correctAudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *wrongAudioPlayer;

@property NSInteger userScore;

@end

NSInteger CORRECT_SCORE_VALUE = 10; // Maybe configure on server?
NSInteger INCORRECT_SCORE_VALUE = -10;

@implementation GameEngine

#pragma mark -
#pragma mark SetUp

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self instantiateIvars];
    }
    return self;
}

-(void)instantiateIvars
{
    self.questionController = [[QuestionController alloc]init];
    
    NSString *filePathCorrect = [[NSBundle mainBundle]pathForResource:@"correct" ofType:@"wav"];
    NSString *filePathWrong   = [[NSBundle mainBundle]pathForResource:@"wrong" ofType:@"wav"];
    
    self.correctAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePathCorrect] error:NULL];
    self.wrongAudioPlayer   = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePathWrong] error:NULL];
    [self.correctAudioPlayer prepareToPlay];
    [self.wrongAudioPlayer prepareToPlay];
}

#pragma mark -
#pragma mark GamePlay

-(void)startGame
{
    [self loadNextQuestion];
}

-(void)answerNumberSelected:(NSInteger)answerNumber
{
    NSString *selectedAnswer = [self.currentModel.answers objectAtIndex:answerNumber - 1];
    NSString *correctAnswer  = self.currentModel.correctAnswer;
    
    if ([selectedAnswer isEqualToString:correctAnswer]) {
        [self notifyUserAnswerWasCorrect:YES];
        [self updateUserScore:CORRECT_SCORE_VALUE];
    } else {
        [self notifyUserAnswerWasCorrect:NO];
        [self updateUserScore:INCORRECT_SCORE_VALUE];
    }
    
    [self loadNextQuestion];
}

-(void)loadNextQuestion
{
    QuestionAnswerCompModel *nextModel = [self.questionController loadNextQuestion];
    
    if (nextModel) {
        self.currentModel = nextModel;
        [self.delegate gameEngineDelegateDidLoadNextQuestion:nextModel];
    } else {
        [self gameEnded];
    }
}

-(void)notifyUserAnswerWasCorrect:(BOOL)answerCorrect
{
    if (answerCorrect) {
        [self.correctAudioPlayer play];
    } else {
        [self.wrongAudioPlayer play];
    }
    
    [self.delegate gameEngineDelegateDidConfirmAnswerIsCorrect:answerCorrect];
}

-(void)updateUserScore:(NSInteger)newPoints
{
    self.userScore += newPoints;
    // Extra Points *x for answering quick?
}

-(void)gameEnded
{
    // get total score
    // check if can add to high score table (server and local?)
    // go back to home screen / high score table
}


@end
