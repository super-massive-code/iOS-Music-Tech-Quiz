//
//  BaseViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark -
#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];  
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

#pragma mark -
#pragma mark ProgressHUD

-(void)startProgressHudWithMessage:(NSString*)message
{
    
}

-(void)stopProgressHud
{
    
}

#pragma mark -
#pragma mark Alerts

-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    
}

@end
