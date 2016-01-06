//
//  HomeViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark ViewControllerDataSource

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark SetUp

-(void)setUpUi
{
    self.navigationController.navigationBar.hidden = YES;
}

@end
