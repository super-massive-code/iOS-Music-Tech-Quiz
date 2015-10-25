//
//  ViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerViewController.h"
#import "QuestionModel.h"
#import "QuestionController.h"

@import AVFoundation;

@interface QuestionAnswerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) QuestionModel *currentModel;
@property (strong, nonatomic) QuestionController *questionController;

@property (strong, nonatomic) AVAudioPlayer *correctAudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *wrongAudioPlayer;

@property NSInteger userScore;

@end

NSInteger CORRECT_SCORE_VALUE = 10;
NSInteger INCORRECT_SCORE_VALUE = -10;

@implementation QuestionAnswerViewController

#pragma mark -
#pragma mark VCLifeCycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self instantiateIvars];
    [self loadNextQuestion];
}

#pragma mark -
#pragma mark SetUp

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
#pragma mark TableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentModel.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"answerCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString *answer = [self.currentModel.answers objectAtIndex:indexPath.row];
    cell.textLabel.text = answer;
    
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedAnswer = [self.currentModel.answers objectAtIndex:indexPath.row];
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

#pragma mark -
#pragma mark Load Question

-(void)loadNextQuestion
{
    QuestionModel *nextModel = [self.questionController loadNextQuestion];
    
    if (nextModel) {
        self.currentModel = nextModel;
        self.questionLabel.text = self.currentModel.question;
        [self.tableView reloadData];
    } else {
        [self gameEnded];
    }
}

#pragma mark -
#pragma mark Answer Notification

-(void)notifyUserAnswerWasCorrect:(BOOL)answerCorrect
{
    //todo: find way of making the sampler retrigger instantly
    // also need to trim wavs
    
    if (answerCorrect) {
        [self.correctAudioPlayer play];
    } else {
        [self.wrongAudioPlayer play];
    }
 
    // Animation?
    // UI Notification / Toast
}

#pragma -
#pragma User Score

-(void)updateUserScore:(NSInteger)newPoints
{
    self.userScore += newPoints;
    // Extra Points *x for answering quick?
}

#pragma -
#pragma - Game Ended

-(void)gameEnded
{
    // get total score
    // check if can add to high score table (server and local?)
    // go back to home screen / hight score table
}

@end
