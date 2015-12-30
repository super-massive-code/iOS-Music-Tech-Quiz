//
//  QuestionAnswerParser.h
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionAnswerParser : NSObject

+(void)parseUpdateResponse:(NSDictionary *)updateDict;

@end
