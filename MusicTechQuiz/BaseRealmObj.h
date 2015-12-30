//
//  BaseRealmObj.h
//  MusicTechQuiz
//
//  Created by Carl  on 23/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import <Realm/Realm.h>

@interface BaseRealmObj : RLMObject
@property NSDate *created;
@property NSDate *updated;
@property NSNumber <RLMInt>*remote_id;

@end

@interface Answer: BaseRealmObj
@property NSString *title;
@property BOOL isCorrectAnswer;

-(void)updateOrCreate;

@end
RLM_ARRAY_TYPE(Answer)

@interface Question : BaseRealmObj
@property NSString *title;
@property RLMArray<Answer>*answers;
@end
