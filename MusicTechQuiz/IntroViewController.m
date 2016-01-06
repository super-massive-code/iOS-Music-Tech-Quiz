//
//  IntroViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

NSString * const segueQuestionAnswerVC = @"segueQuestionAnswerVC";

@implementation IntroViewController

#pragma mark -
#pragma mark ViewControllerLifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self startIntroProcess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Intro

-(void)startIntroProcess
{
    NSMutableArray *messages = [self createMessages];
    [self animateMessages:messages WithCallBack:^{
        [self startGame];
    }];
}

-(NSMutableArray*)createMessages
{
    NSMutableArray *messages = [[NSMutableArray alloc]init];
    [messages addObject:@"Get\nReady!"];
    [messages addObject:@"3"];
    [messages addObject:@"2"];
    [messages addObject:@"1"];
    [messages addObject:@"Go!"];
    
    return messages;
}

-(void)animateMessages:(NSMutableArray*)messages WithCallBack:(void(^)(void))callBack
{
    NSString *messageString = [messages objectAtIndex:0];
    self.messageLabel.text = messageString;
    [messages removeObjectAtIndex:0];
    
    CGAffineTransform transformGrow   = CGAffineTransformMakeScale(4.0f, 4.0f);
    CGAffineTransform transformShrink = CGAffineTransformMakeScale(1.0f, 1.0f);
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.messageLabel.transform = transformGrow;
    } completion:^(BOOL finished) {
        self.messageLabel.transform = transformShrink;
        if (messages.count > 0) {
            [self animateMessages:messages WithCallBack:callBack];
        } else {
            callBack();
        }
    }];
}

#pragma mark -
#pragma mark StartGame

-(void)startGame
{
    [self performSegueWithIdentifier:segueQuestionAnswerVC sender:self];
}

@end
