//
//  Update.h
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Realm/Realm.h>

@interface PendingUpdate : RLMObject

@property NSDate *created;
@property NSNumber <RLMInt> *remoteId;
@property NSString *modelType;

@end
