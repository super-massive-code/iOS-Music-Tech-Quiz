//
//  IntroViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "IntroViewController.h"
#import "GlobalConstants.h"
#import <QuartzCore/QuartzCore.h>

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
    [self setUpUi];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self startIntroProcess];
}

#pragma mark -
#pragma mark SetUp

-(void)setUpUi
{
    [super setUpUi];
    
    self.messageLabel.font = [FontConstants secondaryTitleFont];
    self.messageLabel.textColor = [ColourConstants primaryTextColour];
    
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark -
#pragma mark GenerateIntro

-(void)startIntroProcess
{
    NSMutableArray *messages = [self createMessages];
    
    int totalAnimationDurationSeconds = 5;
    float individualAnimationTime = totalAnimationDurationSeconds/messages.count;
    
    UIView *circles = [self createCircles];
    [self.view insertSubview:circles atIndex:0];
    
    [self animateMessages:messages andView:circles forDuration:individualAnimationTime WithCallBack:^{
        self.messageLabel.text = @"";
        [self animateView:circles toExpandOffScreenWithCallBack:^{
            [self startGame];
        }];
    }];
}

-(NSMutableArray*)createMessages
{
    NSMutableArray *messages = [[NSMutableArray alloc]init];
    [messages addObject:@"3"];
    [messages addObject:@"2"];
    [messages addObject:@"1"];
    [messages addObject:@"Go!"];
    
    return messages;
}

#pragma mark -
#pragma mark Animation

-(void)animateMessages:(NSMutableArray*)messages andView:(UIView*)circleView forDuration:(float)duration WithCallBack:(void(^)(void))callBack
{
    NSString *messageString = [messages objectAtIndex:0];
    self.messageLabel.text = messageString;
    [messages removeObjectAtIndex:0];
    
    CGAffineTransform transformGrowText   = CGAffineTransformMakeScale(4.0f, 4.0f);
    CGAffineTransform transformGrowCircle = CGAffineTransformMakeScale(1.2f, 1.2f);
    CGAffineTransform transformShrink     = CGAffineTransformMakeScale(1.0f, 1.0f);
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            self.messageLabel.transform = transformGrowText;
                            circleView.transform        = transformGrowCircle;
                            
                        } completion:^(BOOL finished) {
                            
                            self.messageLabel.transform = transformShrink;
                            circleView.transform        = transformShrink;
                            
                            if (messages.count > 0) {
                                [self animateMessages:messages andView:circleView forDuration:duration WithCallBack:callBack];
                            } else {
                                callBack();
                            }
                        }];
}

-(void)animateView:(UIView*)view toExpandOffScreenWithCallBack:(void(^)(void))callBack
{
    CGAffineTransform transformGrowCircle = CGAffineTransformMakeScale(10.0f, 10.0f);
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform = transformGrowCircle;
    } completion:^(BOOL finished) {
        callBack();
    }];
}

#pragma mark -
#pragma mark Circles

-(UIView*)createCircles
{
    float diamieter = self.view.bounds.size.width / 2;
    
    UIView *circleView = [[UIView alloc]init];
    circleView.center = self.view.center;
    circleView.backgroundColor = [ColourConstants primaryBackgroundColour];
    [self roundView:circleView toDiameter:diamieter];
    
    UIView *innerCircleView = [[UIView alloc]init];
    innerCircleView.backgroundColor = [ColourConstants secondaryBackgroundColour];
    [self roundView:innerCircleView toDiameter:diamieter - 20];
    innerCircleView.center = CGPointMake(circleView.bounds.size.width / 2, circleView.bounds.size.width / 2);
    
    [circleView addSubview:innerCircleView];
    return circleView;
}

-(void)roundView:(UIView *)view toDiameter:(float)newSize;
{
    CGPoint saveCenter = view.center;
    CGRect newFrame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newSize, newSize);
    view.frame = newFrame;
    view.layer.cornerRadius = newSize / 2.0;
    view.center = saveCenter;
}

#pragma mark -
#pragma mark StartGame

-(void)startGame
{
    [self performSegueWithIdentifier:segueQuestionAnswerVC sender:self];
}

@end
