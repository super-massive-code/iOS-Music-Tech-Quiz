//
//  ServerComms.h
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTTP_METHOD) {
    HTTP_METHOD_GET,
    HTTP_METHOD_POST
};

@class ServerResponse;


@interface ServerComms : NSObject

-(void)postJSON:(id)JSON toUrl:(NSString*)urlString withHttpMethod:(HTTP_METHOD)httpMethod CallBack:(void(^)(ServerResponse *responseObject))callBack;

@end
