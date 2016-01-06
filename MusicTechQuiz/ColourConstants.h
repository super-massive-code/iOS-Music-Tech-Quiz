//
//  ColourConstants.h
//  MusicTechQuiz
//
//  Created by Carl  on 06/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;

@interface ColourConstants : NSObject

#pragma mark - Backgrounds
+(UIColor*)primaryBackgroundColour;
+(UIColor*)secondaryBackgroundColour;

#pragma mark - Text
+(UIColor*)primaryTextColour;

#pragma mark - Notification
+(UIColor*)primaryGood;
+(UIColor*)primaryBad;

@end
