//
//  HomeViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "HomeViewController.h"
#import "GlobalConstants.h"
#import "UpdateController.h"
#import "QuestionController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UpdateController *updateController;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;

@end

@implementation HomeViewController

#pragma mark -
#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUi];
    [self checkIfCanShowStartButton];
}

#pragma mark -
#pragma mark SetUp

-(void)setUpUi
{
    [super setUpUi];
    
    UIFont *buttonFont  = [FontConstants secondaryTitleFont];
    UIColor *textColour = [ColourConstants primaryTextColour];
    
    UIColor *backgroundColour = [ColourConstants primaryBackgroundColour];
    self.view.backgroundColor = backgroundColour;
    
    for (UIButton *button in self.buttons) {
        button.layer.borderColor = textColour.CGColor;
        button.layer.borderWidth = 2.0f;
        button.layer.cornerRadius = 10.0f;
        [button setTitleColor:textColour forState:UIControlStateNormal];
        [button.titleLabel setFont:buttonFont];
    }
}

#pragma mark -
#pragma mark CanShowStartButton

-(void)checkIfCanShowStartButton
{
    self.startGameButton.hidden = YES;
    
    if ([QuestionController doesHaveQuestionsInDatabase]) {
        self.startGameButton.hidden = NO;
    }
}

#pragma mark -
#pragma mark UserActions

- (IBAction)updateDataButtonPressed:(UIButton *)sender
{
    self.updateController = [[UpdateController alloc]init];
    
    [super startProgressHudWithMessage:@"Checking for updates..." hudInViewCallBack:^{
        [self.updateController checkForNewUpdatesOnServer:^{
            [self.updateController checkForPendingUpdatesOnClient:^{
                [super stopProgressHud];
                [self checkIfCanShowStartButton];
            }];
        }];
    }];
}

@end
