//
//  Update.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "PendingUpdate.h"

@implementation PendingUpdate

-(NSString *)description
{
    return [NSString stringWithFormat:@"Created:%@\nRemoteID:%@\nModelType:%@", self.created, self.remoteId, self.modelType];
}

@end
