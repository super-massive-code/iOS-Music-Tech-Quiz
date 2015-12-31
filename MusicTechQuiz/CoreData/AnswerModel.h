//
//  AnswerModel.h
//  
//
//  Created by Carl  on 31/12/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionModel;

NS_ASSUME_NONNULL_BEGIN

@interface AnswerModel : NSManagedObject

-(void)updateOrCreateFromDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END

#import "AnswerModel+CoreDataProperties.h"
