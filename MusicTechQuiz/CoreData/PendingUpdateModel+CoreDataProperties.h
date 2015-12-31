//
//  PendingUpdateModel+CoreDataProperties.h
//  
//
//  Created by Carl  on 31/12/2015.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PendingUpdateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PendingUpdateModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *created;
@property (nullable, nonatomic, retain) NSString *modelType;
@property (nullable, nonatomic, retain) NSNumber *remoteId;

@end

NS_ASSUME_NONNULL_END
