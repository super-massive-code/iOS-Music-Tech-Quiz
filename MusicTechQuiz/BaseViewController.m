//
//  BaseViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *progressHud;

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

-(void)startProgressHudWithMessage:(NSString*)message hudInViewCallBack:(void(^)(void))callback
{
    self.progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHud.mode = MBProgressHUDModeIndeterminate;
    self.progressHud.labelText = message;
    
    if (callback) {
        // Slight delay to guarantee Hud can get into main run loop before next request
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            callback();
        });
    }
}

-(void)stopProgressHud
{
    // Delay so really quick network requests dont cause Hud to flash up and disappear to quickly
    [self.progressHud hide:YES afterDelay:2.0];
}

#pragma mark -
#pragma mark Alerts

-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    
}

@end
