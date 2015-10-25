//
//  ServerComms.h
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerResponseObject : NSObject

@property (nonatomic, strong) NSString *userMessage;
@property BOOL connectionMade;
@property NSDictionary *responseDict;
@property NSError *error;

@end

@implementation ServerResponseObject
@end


@interface ServerComms : NSObject

-(void)postJSON:(id)JSON toUrl:(NSString*)urlString withCallBack:(void(^)(ServerResponseObject *responseObject))callBack;

@end
