//
//  QuestionAnswerViewControllerNew.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerViewControllerNew.h"
#import "GameEngine.h"
#import "QuestionAnswerCompModel.h"
#import "UIColor+RgbDivided.h"

@interface QuestionAnswerViewControllerNew () <GameEngineDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (nonatomic, strong) GameEngine *gameEngine;

@property (weak, nonatomic) IBOutlet UIButton *answerButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonTwo;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonFour;

@end

@implementation QuestionAnswerViewControllerNew

#pragma mark -
#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUi];
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

-(void)setUpUi
{
    UIColor *backGroundColour = [UIColor dividedColorWithRed:149 green:165 blue:166 alpha:1];
    self.view.backgroundColor = backGroundColour;
}

#pragma mark -
#pragma mark UserActions

- (IBAction)AnswerButtonPressed:(UIButton *)button
{
    [self.gameEngine answerNumberSelected:button.tag];
}

#pragma mark -
#pragma mark UiUpdates

-(void)updateUiWithModel:(QuestionAnswerCompModel*)model
{
    NSArray *answers = model.answers;
    [self.answerButtonOne setTitle:[answers objectAtIndex:0] forState:UIControlStateNormal];
    [self.answerButtonTwo setTitle:[answers objectAtIndex:1] forState:UIControlStateNormal];
    [self.answerButtonThree setTitle:[answers objectAtIndex:2] forState:UIControlStateNormal];
    [self.answerButtonFour setTitle:[answers objectAtIndex:3] forState:UIControlStateNormal];
    
    self.questionLabel.text = model.question;
}

#pragma mark -
#pragma mark GameEngineDelegates

-(void)gameEngineDelegateDidConfirmAnswerIsCorrect:(BOOL)answerCorrect
{
    
}

-(void)gameEngineDelegateDidLoadNextQuestion:(QuestionAnswerCompModel *)model
{
    [self updateUiWithModel:model];
}

-(void)gameEngineDelegateDidEndWithTotalScore:(NSInteger)totalScore
{
    
}

@end
