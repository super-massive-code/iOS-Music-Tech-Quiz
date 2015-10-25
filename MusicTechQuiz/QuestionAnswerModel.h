//
//  QuestionAnswerModel.h
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionAnswerModel : NSObject

@property (nonatomic, copy, readonly) NSArray *answers;

@property (nonatomic, copy, readonly) NSString *question;
@property (nonatomic, copy, readonly) NSString *correctAnswer;


-(instancetype)initWithQuestion:(NSString*)question answers:(NSArray*)answers correctAnswer:(NSString*)correctAnswer;

@end
