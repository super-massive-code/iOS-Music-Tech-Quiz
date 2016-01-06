//
//  GameEngine.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "GameController.h"
#import "QuestionAnswerCompModel.h"
#import "QuestionController.h"

@import AVFoundation;

@interface GameController ()

@property (strong, nonatomic) QuestionAnswerCompModel *currentModel;
@property (strong, nonatomic) QuestionController *questionController;

@property (strong, nonatomic) AVAudioPlayer *correctAudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *wrongAudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *timeOutAudioPlayer;

@property (strong, nonatomic) NSTimer *timer;

@property NSInteger userScore;
@property float timeLeft;

@end

// Maybe configure these on server?
NSInteger CORRECT_SCORE_VALUE = 10;
NSInteger INCORRECT_SCORE_VALUE = -10;
NSInteger SECONDS_TO_ANSWER_QUESION = 1.0;

@implementation GameController

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
    NSString *filePathTimeOut = [[NSBundle mainBundle]pathForResource:@"time_out" ofType:@"wav"];
    
    self.correctAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePathCorrect] error:NULL];
    self.wrongAudioPlayer   = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePathWrong] error:NULL];
    self.timeOutAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePathTimeOut] error:NULL];
    
    [self.correctAudioPlayer prepareToPlay];
    [self.wrongAudioPlayer prepareToPlay];
    [self.timeOutAudioPlayer prepareToPlay];
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
        [self.delegate gameControllerDelegateDidLoadNextQuestion:nextModel];
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
    
    [self.delegate gameControllerDelegateDidConfirmAnswerIsCorrect:answerCorrect forUserAnswer:userAnswer withCorrectAnswer:correctAnswer];
}

-(void)updateUserScore:(NSInteger)newPoints
{
    self.userScore += newPoints;
    // Extra Points *x for answering quick?
}

-(void)gameEnded
{
    [self.delegate gameControllerDelegateDidEndWithTotalScore:[NSNumber numberWithInteger:self.userScore]];
}

#pragma mark -
#pragma mark Timer

-(void)restartTimer
{
    [self stopTimer];
    self.timeLeft = SECONDS_TO_ANSWER_QUESION;
    [self updateTimeLeftOnDelegate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

-(void)stopTimer
{
    [self.timer invalidate];
}

-(void)updateTime
{
    self.timeLeft -= 0.01;
    [self updateTimeLeftOnDelegate];
    if (self.timeLeft <= 0.0) {
        [self timeRanOut];
    }
}

-(void)timeRanOut
{
    [self.timeOutAudioPlayer play];
    [self stopTimer];
    [self.delegate gameControllerDelegateTimerDidRunOut];
}

-(void)updateTimeLeftOnDelegate
{
    if ([self.delegate respondsToSelector:@selector(gameControllerDelegateTimeUpdate:)]) {
        [self.delegate gameControllerDelegateTimeUpdate:self.timeLeft];
    }
}

@end
