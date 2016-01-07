//
//  GameOverViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "GameOverViewController.h"
#import "GlobalConstants.h"

@interface GameOverViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation GameOverViewController

#pragma mark -
#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUi];
    [self setScore];
}

#pragma mark -
#pragma mark SetUp

-(void)setUpUi
{
    [super setUpUi];
    
    UIFont *buttonFont  = [FontConstants secondaryTitleFont];
    UIFont *pointsFont = [FontConstants titleFont];

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
    
    self.scoreLabel.textColor = textColour;
    self.scoreLabel.font = pointsFont;
}

#pragma mark -
#pragma mark Score

-(void)setScore
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Your Score\n%@", self.userScore];
}

#pragma mark -
#pragma mark UserActions

- (IBAction)homeButtonPressed:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];    
}

@end
