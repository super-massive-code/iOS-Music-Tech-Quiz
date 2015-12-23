//
//  ServerResponseObject.m
//  mpc-audio
//
//  Created by Carl  on 11/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "ServerResponse.h"

@implementation ServerResponse

-(NSString*)description
{
    return [NSString stringWithFormat:@"UserMessage: %@\nConnectionMade: %i\nResponseDict: %@\nNSError: %@\n", self.userMessage, self.connectionMade, self.responseDict, self.error];
}

@end
