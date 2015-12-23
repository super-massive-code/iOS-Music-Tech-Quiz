//
//  ServerResponseObject.h
//  mpc-audio
//
//  Created by Carl  on 11/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerResponse : NSObject

@property (nonatomic, strong) NSString *userMessage;
@property BOOL connectionMade;
@property NSDictionary *responseDict;
@property NSError *error;

@end
