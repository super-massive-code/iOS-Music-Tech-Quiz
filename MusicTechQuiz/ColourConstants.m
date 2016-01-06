//
//  ColourConstants.m
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "ColourConstants.h"
#import <UIKit/UIKit.h>
#import "UIColor+RgbDivided.h"

@implementation ColourConstants

#pragma mark -
#pragma mark - Backgrounds

+(UIColor*)primaryBackgroundColour
{
    return [UIColor dividedColorWithRed:51 green:111 blue:151 alpha:1];
}

+(UIColor*)secondaryBackgroundColour
{
    return [UIColor dividedColorWithRed:85 green:176 blue:241 alpha:1];;
}

#pragma mark -
#pragma mark - Text

+(UIColor*)primaryTextColour
{
    return [UIColor whiteColor];
}

#pragma mark -
#pragma mark - Notification

+(UIColor*)primaryGood
{
    return [UIColor dividedColorWithRed:46 green:204 blue:113 alpha:1];
}

+(UIColor*)primaryBad
{
    return [UIColor dividedColorWithRed:231 green:76 blue:60 alpha:1];
}

@end
