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

@property (strong, nonatomic) NSTimer *timer;

@property NSInteger userScore;
@property NSInteger currentTime;

@end

// Maybe configure these on server?
NSInteger CORRECT_SCORE_VALUE = 10;
NSInteger INCORRECT_SCORE_VALUE = -10;
NSInteger QUESTION_TIME_LIMT = 10;

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

-(void)answerSelected:(NSString*)selectedAnswer
{
    [self stopTimer];
    
    if ([selectedAnswer isEqualToString:self.currentModel.correctAnswer]) {
        [self notifyUserAnswerWasCorrect:YES userAnswer:selectedAnswer correctAnswer:self.currentModel.correctAnswer];
        [self updateUserScore:CORRECT_SCORE_VALUE];
    } else {
        [self notifyUserAnswerWasCorrect:NO userAnswer:selectedAnswer correctAnswer:self.currentModel.correctAnswer];
        [self updateUserScore:INCORRECT_SCORE_VALUE];
    }
}

-(void)loadNextQuestion
{
    QuestionAnswerCompModel *nextModel = [self.questionController loadNextQuestion];
    
    if (nextModel) {
        self.currentModel = nextModel;
        [self.delegate gameEngineDelegateDidLoadNextQuestion:nextModel];
        [self restartTimer];
    } else {
        [self gameEnded];
    }
}

-(void)notifyUserAnswerWasCorrect:(BOOL)answerCorrect userAnswer:(NSString*)userAnswer correctAnswer:(NSString*)correctAnswer
{
    if (answerCorrect) {
        [self.correctAudioPlayer play];
    } else {
        [self.wrongAudioPlayer play];
    }
    
    [self.delegate gameEngineDelegateDidConfirmAnswerIsCorrect:answerCorrect forUserAnswer:userAnswer withCorrectAnswer:correctAnswer];
}

-(void)updateUserScore:(NSInteger)newPoints
{
    self.userScore += newPoints;
    // Extra Points *x for answering quick?
}

-(void)gameEnded
{    
    [self.delegate gameEngineDelegateDidEndWithTotalScore:[NSNumber numberWithInteger:self.userScore]];
}

#pragma mark -
#pragma mark Timer

-(void)restartTimer
{
    [self stopTimer];
    self.currentTime = 0;
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

-(void)stopTimer
{
   [self.timer invalidate];
}

-(void)updateTime
{
    self.currentTime++;
    if (self.currentTime >= QUESTION_TIME_LIMT) {
        [self stopTimer];
        [self.delegate gameEngineDelegateTimerDidRunOut];
    }
}

@end
