//
//  QuestionAnswerViewControllerNew.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerViewControllerNew.h"
#import "GameEngine.h"

@interface QuestionAnswerViewControllerNew () <GameEngineDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (nonatomic, strong) GameEngine *gameEngine;

@end

@implementation QuestionAnswerViewControllerNew

#pragma mark -
#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpGameEngine];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SetUp

-(void)setUpGameEngine
{
    self.gameEngine = [[GameEngine alloc]init];
    self.gameEngine.delegate = self;
    [self.gameEngine startGame];
}

#pragma mark -
#pragma mark UserActions

- (IBAction)AnswerButtonPressed:(UIButton *)button
{
    [self.gameEngine answerNumberSelected:button.tag];
}

#pragma mark -
#pragma mark GameEngineDelegates

-(void)gameEngineDelegateDidConfirmAnswerIsCorrect:(BOOL)answerCorrect
{
    
}

-(void)gameEngineDelegateDidLoadNextQuestion:(QuestionAnswerCompModel *)model
{
    
}

-(void)gameEngineDelegateDidEndWithTotalScore:(NSInteger)totalScore
{
    
}

@end
