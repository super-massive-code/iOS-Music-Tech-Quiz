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
#import "GameOverViewController.h"

@interface QuestionAnswerViewControllerNew () <GameEngineDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (nonatomic, strong) GameEngine *gameEngine;

@property (weak, nonatomic) IBOutlet UIButton *answerButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonTwo;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonFour;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answerButtons;

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSNumber*)userScore
{
    GameOverViewController *vc = segue.destinationViewController;
    vc.userScore = userScore;
}

#pragma mark -
#pragma mark ViewControllerDataSource

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark SetUp

-(void)setUpGameEngine
{
    self.gameEngine = [[GameEngine alloc]init];
    self.gameEngine.delegate = self;
    [self.gameEngine loadNextQuestion];
}

-(void)setUpUi
{
    self.navigationController.navigationBar.hidden = YES;
    
    NSString *fontName = @"Helvetica-Bold";
    UIFont *questionFont = [UIFont fontWithName:fontName size:30];
    UIFont *answerFont = [UIFont fontWithName:fontName size:25];
    
    UIColor *backgroundColour = [UIColor dividedColorWithRed:51 green:111 blue:151 alpha:1];
    UIColor *headerFooterBackgroundColour = [UIColor dividedColorWithRed:85 green:176 blue:241 alpha:1];
    UIColor *textColour = [UIColor whiteColor];
    
    self.view.backgroundColor = backgroundColour;
    
    for (UIButton *button in self.answerButtons) {
        button.layer.borderColor = textColour.CGColor;
        button.layer.borderWidth = 2.0f;
        button.layer.cornerRadius = 10.0f;
        [button setTitleColor:textColour forState:UIControlStateNormal];
        [button.titleLabel setFont:answerFont];
    }
    
    self.headerView.backgroundColor = headerFooterBackgroundColour;
    self.footerView.backgroundColor = headerFooterBackgroundColour;
    
    self.questionLabel.textColor = textColour;
    self.questionLabel.font = questionFont;
}

#pragma mark -
#pragma mark UserActions

- (IBAction)AnswerButtonPressed:(UIButton *)button
{
    [self.gameEngine answerSelected:button.titleLabel.text];
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

-(void)animateAnswerButton:(UIButton*)button asCorrectAnswer:(BOOL)isCorrectAnswer correctAnswer:(NSString*)correctAnswer callBack:(void(^)(void))callBack
{
    UIColor *selectedButtonColour;
    UIColor *correctAnswerColour = [UIColor dividedColorWithRed:46 green:204 blue:113 alpha:1];
    UIColor *wrongAnswerColour = [UIColor dividedColorWithRed:231 green:76 blue:60 alpha:1];
    
    if (isCorrectAnswer) {
        selectedButtonColour = correctAnswerColour;
    } else {
        selectedButtonColour = wrongAnswerColour;
    }
    
    [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.backgroundColor = selectedButtonColour;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (isCorrectAnswer) {
                callBack();
            } else {
                [self animateCorrectAnswer:correctAnswer toColour:correctAnswerColour WithCallBack:^{
                    callBack();
                }];
            }
        });
    }];
}

-(void)animateCorrectAnswer:(NSString*)correctAnswer toColour:(UIColor*)correctAnswerColour WithCallBack:(void(^)(void))callBack
{
    UIButton *correctAnswerButton;
    NSMutableArray *wrongAnswerButtons = [[NSMutableArray alloc]init];
    
    for (UIButton *button in self.answerButtons) {
        if ([button.titleLabel.text isEqualToString:correctAnswer]) {
            correctAnswerButton = button;
        } else {
            [wrongAnswerButtons addObject:button];
        }
    }
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        correctAnswerButton.backgroundColor = correctAnswerColour;
        for (UIButton *button in wrongAnswerButtons) {
            button.alpha = 0;
        }
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            callBack();
        });
    }];
}

-(void)resetStateOfButtons
{
    for (UIButton *button in self.answerButtons) {
        button.backgroundColor = [UIColor clearColor];
        button.alpha = 1;
    }
}

#pragma mark -
#pragma mark GameEngineDelegates

-(void)gameEngineDelegateDidConfirmAnswerIsCorrect:(BOOL)answerCorrect forUserAnswer:(NSString *)userAnswer withCorrectAnswer:(NSString *)correctAnswer
{
    UIButton *userAnswerButton;
    for (UIButton *button in self.answerButtons) {
        if ([button.titleLabel.text isEqualToString:userAnswer]) {
            userAnswerButton = button;
            break;
        }
    }
    
    __weak QuestionAnswerViewControllerNew *weakSelf = (QuestionAnswerViewControllerNew*)self;
    [self animateAnswerButton:userAnswerButton asCorrectAnswer:answerCorrect correctAnswer:correctAnswer callBack:^{
        [weakSelf resetStateOfButtons];
        [weakSelf.gameEngine loadNextQuestion];
    }];
}

-(void)gameEngineDelegateDidLoadNextQuestion:(QuestionAnswerCompModel *)model
{
    [self updateUiWithModel:model];
}

-(void)gameEngineDelegateDidEndWithTotalScore:(NSNumber*)totalScore
{
    [self performSegueWithIdentifier:@"segGameOver" sender:totalScore];
}

@end
