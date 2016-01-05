//
//  GameOverViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@end

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeButtonPressed:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];    
}

@end
