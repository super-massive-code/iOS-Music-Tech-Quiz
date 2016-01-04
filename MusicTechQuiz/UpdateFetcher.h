//
//  UpdateQueue.h
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateFetcher : NSObject

-(void)fetchUrls:(NSMutableArray*)updateUrls usingParser:(id)parser complete:(void(^)(void))complete;

@end
