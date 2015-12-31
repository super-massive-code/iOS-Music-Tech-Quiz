//
//  QuestionAnswerParser.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerUpdateParser.h"
#import "ServerConstants.h"
#import "QuestionModel.h"
#import "AnswerModel.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation QuestionAnswerUpdateParser

+(void)parseUpdateResponse:(NSDictionary *)updateDict
{
    NSString *modelType = [updateDict objectForKey:@"model_type"];
    
    if ([modelType isEqualToString:kServerModelTypeQuestion]) {

    } else if ([modelType isEqualToString:kServerModelTypeAnswer]) {
    
    } else {
        [NSException raise:@"** Invalid State **" format:@"Model type not recognised"];
    }  
}

+(void)p {
//    NSNumber *remoteId  = [dict objectForKey:@"id"];
//    AnswerModel *answer = [AnswerModel MR_findFirstByAttribute:@"remoteId" withValue:remoteId];
//    
//    if (!answer) {
//        answer = [AnswerModel MR_createEntity];
//        answer.remoteId = remoteId;
//    }
//    
//    answer.title = [dict objectForKey:@"title"];
//    
//    return answer;
}

@end
