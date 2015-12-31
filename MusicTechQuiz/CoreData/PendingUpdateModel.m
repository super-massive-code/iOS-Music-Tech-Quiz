//
//  PendingUpdateModel.m
//  
//
//  Created by Carl  on 31/12/2015.
//
//

#import "PendingUpdateModel.h"

@implementation PendingUpdateModel

-(NSString *)description
{
    return [NSString stringWithFormat:@"Created:%@\nRemoteID:%@\nModelType:%@", self.created, self.remoteId, self.modelType];
}


@end
