//
//  BaseViewController.h
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)setUpUi;
-(void)startProgressHudWithMessage:(NSString*)message;
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message;

@end
