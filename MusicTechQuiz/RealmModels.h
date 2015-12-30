//
//  BaseRealmObj.h
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmModels : RLMObject
@end

@interface Answer: RLMObject
@property NSDate *created;
@property NSDate *updated;
@property NSNumber <RLMInt>*remoteId;
@property NSString *title;
@property BOOL isCorrectAnswer;

+(void)updateOrCreateFromDict:(NSDictionary*)dict;

@end
RLM_ARRAY_TYPE(Answer)

@interface Question : RealmModels
@property NSDate *created;
@property NSDate *updated;
@property NSNumber <RLMInt>*remoteId;
@property NSString *userName;
@property NSString *title;
@property RLMArray<Answer>*answers;

+(void)updateOrCreateFromDict:(NSDictionary*)dict;

@end
