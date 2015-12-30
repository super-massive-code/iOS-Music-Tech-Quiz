//
//  Update.m
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "Update.h"

@implementation Update

-(NSString *)description
{
    return [NSString stringWithFormat:@"Created:%@\nRemoteID:%@\nModelType:%@", self.created, self.remote_id, self.modelType];
}

@end
