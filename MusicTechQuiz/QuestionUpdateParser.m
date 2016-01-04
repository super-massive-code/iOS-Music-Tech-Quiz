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
   BOOL success = [self createOrUpdateQuestionObjectWithDataDict:updateDict inMoc:moc];
    
    if (success) {
        NSNumber *remoteId = [updateDict objectForKey:@"id"];
        [PendingUpdateParser deleteUpdateObjectForRemoteId:remoteId andModelType:kServerModelTypeQuestion inMoc:moc];
    }
}

+(BOOL)createOrUpdateQuestionObjectWithDataDict:(NSDictionary*)questionDataDict inMoc:(NSManagedObjectContext*)moc
{
    NSNumber *remoteId = [questionDataDict objectForKey:@"id"];
    if (remoteId == nil) {
        //todo: log this error with bug tracking
        return NO;
    }
    
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
    
    return YES;
}

@end
