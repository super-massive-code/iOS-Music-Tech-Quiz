//
//  AnswerModel+CoreDataProperties.h
//  
//
//  Created by Carl  on 31/12/2015.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AnswerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnswerModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *created;
@property (nullable, nonatomic, retain) NSDate *updated;
@property (nullable, nonatomic, retain) NSNumber *remoteId;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *isCorrectAnswer;
@property (nullable, nonatomic, retain) QuestionModel *question;

@end

NS_ASSUME_NONNULL_END
