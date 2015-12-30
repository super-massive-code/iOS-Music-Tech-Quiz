//
//  UpdateUrlBuilder.m
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateUrlBuilder.h"
#import "Update.h"
#import "ServerConstants.h"

@implementation UpdateUrlBuilder

+(NSString*)buildUrlFromModel:(Update*)updateModel andBaseUrl:(NSString*)baseUrl
{
    NSString *endPoint;
    
    if ([updateModel.modelType isEqualToString:kServerModelTypeAnswer]) {
        endPoint = kServerEndPointGetAnswer;
    } else if ([updateModel.modelType isEqualToString:kServerModelTypeQuestion]) {
        endPoint = kServerEndPointGetQuestion;
    } else {
        [NSException raise:@"*** Illegal State ***" format:@"unknown server model type"];
    }
    
    NSString *updateUrl = [NSString stringWithFormat:@"%@%@%@", baseUrl, endPoint, updateModel.remote_id];
    return updateUrl;
}

@end
