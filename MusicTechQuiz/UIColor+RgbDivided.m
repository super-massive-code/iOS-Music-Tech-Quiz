//
//  UIColor+RgbDivided.m
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "UIColor+RgbDivided.h"

@implementation UIColor (RgbDivided)

+(UIColor *)dividedColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    UIColor *colour = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    return colour;
}

@end
