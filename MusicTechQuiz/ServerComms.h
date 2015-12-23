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
    HTTP_METHOD_POST // todo use these
};

@class ServerResponse;


@interface ServerComms : NSObject

-(void)postJSON:(id)JSON toUrl:(NSString*)urlString withCallBack:(void(^)(ServerResponse *responseObject))callBack;

@end
