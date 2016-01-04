//
//  QuestionAnswerParser.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionUpdateParser.h"
#import "ServerConstants.h"
#import "QuestionModel.h"
#import <MagicalRecord/MagicalRecord.h>
#import "PendingUpdateParser.h"

@implementation QuestionUpdateParser

+(void)parseUpdateResponse:(NSDictionary *)updateDict inContext:(NSManagedObjectContext*)moc
{
    NSNumber *remoteId = [updateDict objectForKey:@"id"];
    if (remoteId) {
        [self createOrUpdateQuestionObjectWithDataDict:updateDict forRemoteId:remoteId inMoc:moc];
        [PendingUpdateParser deleteUpdateObjectForRemoteId:remoteId andModelType:kServerModelTypeQuestion inMoc:moc];
    } else {
        // TODO: log with bug tracker
    }
}

+(void)createOrUpdateQuestionObjectWithDataDict:(NSDictionary*)questionDataDict forRemoteId:(NSNumber*)remoteId inMoc:(NSManagedObjectContext*)moc
{
    NSDictionary *userDataDict = [questionDataDict valueForKey:@"user"];
    
    QuestionModel *question = [QuestionModel MR_findFirstByAttribute:@"remoteId" withValue:remoteId inContext:moc];
    
    if (question) {
        question.updated = [NSDate date];
    } else {
        question = [QuestionModel MR_createEntityInContext:moc];
        question.created  = [NSDate date];
        question.remoteId = remoteId;
    }
    
    question.title = [questionDataDict valueForKey:@"title"];
    question.userName = [userDataDict valueForKey:@"name"];
}

@end
