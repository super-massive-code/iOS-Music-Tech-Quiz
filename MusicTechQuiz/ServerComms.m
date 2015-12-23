//
//  ServerComms.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "ServerComms.h"
#import "ServerResponse.h"

@interface ServerComms () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ServerComms

#pragma -
#pragma - Initialization

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.session = [self setUpSession];
    }
    return self;
}

-(NSURLSession *)setUpSession
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders:@{@"Accept": @"application/json"}];
    [sessionConfig setHTTPAdditionalHeaders:@{@"Content-Type": @"application/json"}];
    [sessionConfig setTimeoutIntervalForRequest:30.0];
    [sessionConfig setTimeoutIntervalForResource:60.0];
    [sessionConfig setHTTPMaximumConnectionsPerHost:1];
    [sessionConfig setAllowsCellularAccess:YES];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    return session;
}

#pragma -
#pragma - DispatchMethod

-(void)getJSONfromUrl:(NSString*)urlString callCallBack:(void(^)(ServerResponse *responseObject))callBack
{
    NSURL *nsurl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest =[NSMutableURLRequest requestWithURL:nsurl];
    [urlRequest setHTTPMethod:@"GET"];
    
    [self runRequest:urlRequest WithCallBack:^(ServerResponse *responseObject) {
        return callBack(responseObject);
    }];
}

-(void)postJSON:(id)JSON toUrl:(NSString*)urlString withHttpMethod:(HTTP_METHOD)httpMethod CallBack:(void(^)(ServerResponse *responseObject))callBack
{
    NSError *dataConversionError;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:JSON options:kNilOptions error:&dataConversionError];
    
    if (dataConversionError) {
        return callBack([self createResponseObjectConnectionMade:NO responseDict:nil error:dataConversionError]);
    }
    
    NSURL *nsurl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest =[NSMutableURLRequest requestWithURL:nsurl];
    [urlRequest setHTTPBody:postData];
    
    switch (httpMethod) {
        case HTTP_METHOD_POST:
            [urlRequest setHTTPMethod:@"POST"];
            break;
        default:
            [NSException raise:@"** Invalid State **" format:@"Must pass valid HTTP method"];
            break;
    }
    
    [self runRequest:urlRequest WithCallBack:^(ServerResponse *responseObject) {
        return callBack(responseObject);
    }];
}

#pragma -
#pragma - RunRequest

-(void)runRequest:(NSURLRequest*)request WithCallBack:(void(^)(ServerResponse *responseObject))callBack
{
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data == nil || error) {
            return callBack([self createResponseObjectConnectionMade:NO responseDict:nil error:error]);
        }
        
        NSError *jsonParseError = nil;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
        
        if (jsonParseError) {
            return callBack([self createResponseObjectConnectionMade:YES responseDict:nil error:jsonParseError]);
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        long statusCode = [httpResponse statusCode];
        
        NSString *userMessage;
        
        if (statusCode >= 200 && statusCode < 300) {
            userMessage = nil;
        } else {
            // todo: create status code parser to create user message
        }
        
        return callBack([self createResponseObjectConnectionMade:YES responseDict:jsonDict error:nil]);
        
    }];
    
    [task resume];
}

-(ServerResponse *)createResponseObjectConnectionMade:(BOOL)connectionMade responseDict:(NSDictionary *)responseDict error:(NSError*)error
{
    ServerResponse *obj = [[ServerResponse alloc]init];
    obj.connectionMade = connectionMade;
    obj.responseDict = responseDict;
    obj.error = error;
    return obj;
}

@end
