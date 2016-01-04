//
//  AnswerUpdateParser.h
//  MusicTechQuiz
//
//  Created by Carl  on 04/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface AnswerUpdateParser : NSObject

+(void)parseUpdateResponse:(NSDictionary *)updateDict inContext:(NSManagedObjectContext*)moc;

@end
