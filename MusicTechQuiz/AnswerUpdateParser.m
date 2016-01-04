//
//  AnswerUpdateParser.m
//  MusicTechQuiz
//
//  Created by Carl  on 04/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import "AnswerUpdateParser.h"
#import "ServerConstants.h"
#import "AnswerModel.h"
#import "QuestionModel.h"
#import <MagicalRecord/MagicalRecord.h>
#import "PendingUpdateParser.h"

@implementation AnswerUpdateParser

+(void)parseUpdateResponse:(NSDictionary *)updateDict inContext:(NSManagedObjectContext*)moc
{
    NSNumber *remoteId = [updateDict objectForKey:@"id"];
    if (remoteId) {
        
        AnswerModel *answer = [self createOrUpdateQuestionObjectWithDataDict:updateDict forRemoteId:remoteId inMoc:moc];
        [PendingUpdateParser deleteUpdateObjectForRemoteId:remoteId andModelType:kServerModelTypeAnswer inMoc:moc];
        
        NSDictionary *questionDict = [updateDict objectForKey:@"question"];
        NSNumber *questionId = [questionDict objectForKey:@"id"];
        [self attachAnswer:answer withRemoteId:remoteId ToQuestionForId:questionId inMoc:moc];
        
    } else {
        // TODO: log with bug tracker
    }
}

+(AnswerModel*)createOrUpdateQuestionObjectWithDataDict:(NSDictionary*)answerDataDict forRemoteId:(NSNumber*)remoteId inMoc:(NSManagedObjectContext*)moc
{
    AnswerModel *answer = [AnswerModel MR_findFirstByAttribute:@"remoteId" withValue:remoteId inContext:moc];
    
    if (answer) {
        answer.updated = [NSDate date];
    } else {
        answer = [AnswerModel MR_createEntityInContext:moc];
        answer.created  = [NSDate date];
        answer.remoteId = remoteId;
    }
    
    answer.title = [answerDataDict valueForKey:@"title"];
    answer.isCorrectAnswer = [answerDataDict valueForKey:@"is_correct_answer"];
    
    return answer;
}

+(void)attachAnswer:(AnswerModel*)answer withRemoteId:(NSNumber*)answerRemoteId ToQuestionForId:(NSNumber*)questionRemoteId inMoc:(NSManagedObjectContext*)moc
{
    QuestionModel *question = [QuestionModel MR_findFirstByAttribute:@"remoteId" withValue:questionRemoteId inContext:moc];
    NSSet *savedAnswers = question.answers;
    
    BOOL alreadyAttached = NO;
    
    for (AnswerModel *savedAnswer in savedAnswers) {
        NSNumber *savedAnswerRemoteId = savedAnswer.remoteId;
        if (savedAnswerRemoteId.integerValue == answerRemoteId.integerValue) {
            alreadyAttached = YES;
            break;
        }
    }
    
    if (!alreadyAttached) {
        [question addAnswersObject:answer];
    }
}

@end
