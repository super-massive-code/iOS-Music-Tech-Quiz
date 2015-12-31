//
//  QuestionModel+CoreDataProperties.h
//  
//
//  Created by Carl  on 31/12/2015.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "QuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *created;
@property (nullable, nonatomic, retain) NSDate *updated;
@property (nullable, nonatomic, retain) NSNumber *remoteId;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSSet<AnswerModel *> *answers;

@end

@interface QuestionModel (CoreDataGeneratedAccessors)

- (void)addAnswersObject:(AnswerModel *)value;
- (void)removeAnswersObject:(AnswerModel *)value;
- (void)addAnswers:(NSSet<AnswerModel *> *)values;
- (void)removeAnswers:(NSSet<AnswerModel *> *)values;

@end

NS_ASSUME_NONNULL_END
