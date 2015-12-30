//
//  UpdateUrlBuilder.h
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Update;

@interface UpdateUrlBuilder : NSObject

+(NSString*)buildUrlFromModel:(Update*)updateModel andBaseUrl:(NSString*)baseUrl;

@end
