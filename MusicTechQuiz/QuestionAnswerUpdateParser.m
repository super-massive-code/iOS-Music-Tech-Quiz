//
//  QuestionAnswerParser.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerUpdateParser.h"
#import "RealmModels.h"
#import "ServerConstants.h"

@implementation QuestionAnswerUpdateParser

+(void)parseUpdateResponse:(NSDictionary *)updateDict
{
    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
    
    NSString *modelType = [updateDict objectForKey:@"model_type"];
    
    if ([modelType isEqualToString:kServerModelTypeQuestion]) {
        [self updateQuestionFromDict:updateDict];
    } else if ([modelType isEqualToString:kServerModelTypeAnswer]) {
        [Answer updateOrCreateFromDict:updateDict];
    } else {
        [NSException raise:@"** Invalid State **" format:@"Model type not recognised"];
    }
    
    [realm commitWriteTransaction];
}

+(void)updateQuestionFromDict:(NSDictionary*)dict
{
    NSNumber *remoteId = [dict objectForKey:@"id"];
    NSDictionary *user = [dict objectForKey:@"user"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remoteId == %@", remoteId];
    RLMResults<Question *> *results = [Question objectsWithPredicate:predicate];
    
    Question *question;
    
    if (results.count == 0) {
        question = [[Question alloc]init];
        question.remoteId = remoteId;
    } else {
        question = [results firstObject];
    }
    
    question.title = [dict objectForKey:@"title"];
    question.userName = [user objectForKey:@"name"];
    
    
}

@end
