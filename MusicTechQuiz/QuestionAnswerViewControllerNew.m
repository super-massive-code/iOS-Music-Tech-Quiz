//
//  QuestionAnswerViewControllerNew.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerViewControllerNew.h"
#import "GameController.h"
#import "QuestionAnswerCompModel.h"
#import "GameOverViewController.h"
#import "GlobalConstants.h"

@interface QuestionAnswerViewControllerNew () <GameControllerDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *timeLeftProgressView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@property (weak, nonatomic) IBOutlet UIButton *answerButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonTwo;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *answerButtonFour;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answerButtons;

@property (nonatomic, strong) GameController *gameController;

@end

@implementation QuestionAnswerViewControllerNew

#pragma mark -
#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUi];
    [self setUpGameController];
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
#pragma mark SetUp

-(void)setUpGameController
{
    self.gameController = [[GameController alloc]init];
    self.gameController.delegate = self;
    [self.gameController loadNextQuestion];
}

-(void)setUpUi
{
    [super setUpUi];

    UIFont *questionFont = [FontConstants titleFont];
    UIFont *answerFont = [FontConstants secondaryTitleFont];
    UIFont *pointsFont = [FontConstants regularFont];
    
    UIColor *backgroundColour = [ColourConstants primaryBackgroundColour];
    UIColor *headerFooterBackgroundColour = [ColourConstants secondaryBackgroundColour];
    UIColor *textColour = [ColourConstants primaryTextColour];
    
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
    
    self.pointsLabel.textColor = textColour;
    self.pointsLabel.font = pointsFont;

    CGAffineTransform progressViewTransform = CGAffineTransformMakeScale(1.0f, 4.0f);
    self.timeLeftProgressView.transform = progressViewTransform;
    self.timeLeftProgressView.tintColor = backgroundColour;
}

#pragma mark -
#pragma mark UserActions

- (IBAction)AnswerButtonPressed:(UIButton *)button
{
    [self.gameController answerSelected:button.titleLabel.text];
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
    UIColor *correctAnswerColour = [ColourConstants primaryGood];
    UIColor *wrongAnswerColour   = [ColourConstants primaryBad];
    
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

-(void)animateToNextQuestion
{
    __weak QuestionAnswerViewControllerNew *weakSelf = (QuestionAnswerViewControllerNew*)self;
    [weakSelf animateQuestionChangeOverToAlpha:0 WithCallBack:^{
        [self clearTextForQuestionAndAnswers];
        [weakSelf.gameController loadNextQuestion];
    }];
}

-(void)animateQuestionChangeOverToAlpha:(int)alpha WithCallBack:(void(^)(void))callBack
{
    NSUInteger animationOption;
    if (alpha == 0) {
        animationOption = UIViewAnimationOptionCurveEaseOut;
    } else {
        animationOption = UIViewAnimationOptionCurveEaseIn;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:animationOption animations:^{
        self.questionLabel.alpha = alpha;
    } completion:^(BOOL finished) {
        if (callBack) {
            callBack();
        }
    }];
    
    [self animationButton:self.answerButtonOne   toAlpha:alpha withDelay:0.0 andAnimationOption:animationOption];
    [self animationButton:self.answerButtonTwo   toAlpha:alpha withDelay:0.1 andAnimationOption:animationOption];
    [self animationButton:self.answerButtonThree toAlpha:alpha withDelay:0.2 andAnimationOption:animationOption];
    [self animationButton:self.answerButtonFour  toAlpha:alpha withDelay:0.3 andAnimationOption:animationOption];
}

-(void)animationButton:(UIButton*)button toAlpha:(int)alpha withDelay:(float)delay andAnimationOption:(NSInteger)animationOption
{
    [UIView animateWithDuration:0.5 delay:delay options:animationOption animations:^{
        button.alpha = alpha;
    } completion:nil];
}

-(void)clearTextForQuestionAndAnswers
{
    for (UIButton *button in self.answerButtons) {
        [button setTitle:@"" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
    }
    
    self.questionLabel.text = @"";
}

-(void)buttonsEnabled:(BOOL)enabled
{
    for (UIButton *button in self.answerButtons) {
        button.enabled = enabled;
    }
}

#pragma mark -
#pragma mark GameControllerDelegate

-(void)gameControllerDelegateDidConfirmAnswerIsCorrect:(BOOL)answerCorrect forUserAnswer:(NSString *)userAnswer withCorrectAnswer:(NSString *)correctAnswer
{
    [self buttonsEnabled:NO];
    
    UIButton *userAnswerButton;
    for (UIButton *button in self.answerButtons) {
        if ([button.titleLabel.text isEqualToString:userAnswer]) {
            userAnswerButton = button;
            break;
        }
    }
    
    [self animateAnswerButton:userAnswerButton asCorrectAnswer:answerCorrect correctAnswer:correctAnswer callBack:^{
        [self animateToNextQuestion];
    }];
}

-(void)gameControllerDelegateDidLoadNextQuestion:(QuestionAnswerCompModel *)model
{
    [self buttonsEnabled:YES];
    [self animateQuestionChangeOverToAlpha:1 WithCallBack:^{
        [self updateUiWithModel:model];
    }];
}

-(void)gameControllerDelegateDidEndWithTotalScore:(NSNumber*)totalScore
{
    [self performSegueWithIdentifier:@"segGameOver" sender:totalScore];
}

-(void)gameControllerDelegateTimerDidRunOut
{
    [self buttonsEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateToNextQuestion];
    });
}

-(void)gameControllerDelegateDidUpdateTime:(float)timeLeft
{
//    self.timeLeftProgressView.progress = timeLeft;
}

-(void)gameControllerDelegateDidUpdatePoints:(NSInteger)points
{
    self.pointsLabel.text = [NSString stringWithFormat:@"Score:%li", (long)points];
}

@end
