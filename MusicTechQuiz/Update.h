//
//  Update.h
//  MusicTechQuiz
//
//  Created by Carl  on 30/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Realm/Realm.h>

@interface Update : RLMObject

@property NSDate *created;
@property NSNumber <RLMInt> *remote_id;
@property NSString *modelType;

@end
