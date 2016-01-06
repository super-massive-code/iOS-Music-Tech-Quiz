//
//  FontConstants.m
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "FontConstants.h"
#import <UIKit/UIKit.h>

@implementation FontConstants

NSString * const standardFont = @"Helvetica-Bold";

+(UIFont*)titleFont
{
    return [UIFont fontWithName:standardFont size:30];
}

+(UIFont*)secondaryTitleFont
{
    return [UIFont fontWithName:standardFont size:25];
}

+(UIFont*)regularFont
{
    return [UIFont fontWithName:standardFont size:18];
}

+(UIFont*)detailFont
{
    return [UIFont fontWithName:standardFont size:14];
}

@end
