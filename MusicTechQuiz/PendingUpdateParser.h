//
//  UpdateParser.h
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface PendingUpdateParser : NSObject

+(void)parseUpdateResponse:(NSDictionary *)updateDict inContext:(NSManagedObjectContext*)moc;
+(void)deleteUpdateObjectForRemoteId:(NSNumber*)remoteId;

@end
