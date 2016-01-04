//
//  UpdateQueue.m
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateFetcher.h"
#import "ServerComms.h"
#import "ServerResponse.h"
#import "QuestionUpdateParser.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation UpdateFetcher

-(void)fetchUrls:(NSMutableArray*)updateUrls usingParser:(id)parser complete:(void(^)(void))complete
{
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    
    [self fetchUpdateFromServer:updateUrls parser:parser context:defaultContext complete:^{       
        [defaultContext MR_saveToPersistentStoreAndWait];
        complete();
    }];
}

-(void)fetchUpdateFromServer:(NSMutableArray*)updates parser:(id)parser context:(NSManagedObjectContext*)context complete:(void(^)(void))complete
{
    NSString *updateUrl = [updates objectAtIndex:0];
    [updates removeObjectAtIndex:0];
    
    ServerComms *comms = [[ServerComms alloc]init];
    [comms getJSONfromUrl:updateUrl callCallBack:^(ServerResponse *responseObject) {
        if (responseObject.connectionMade && responseObject.responseDict && !responseObject.error) {
            [parser parseUpdateResponse:responseObject.responseDict inContext:context];
        } else {
            //todo: handle error
            // count so many dropped connections etc before bailing etc?
        }
        
        if (updates.count > 0) {
            [self fetchUpdateFromServer:updates parser:parser context:context complete:complete];
        } else {
            complete();
        }
    }];
}

@end
