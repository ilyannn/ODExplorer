//
//  OIDataQuery.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OperationWithSteps.h"

#import "ODResource.h"

/// This class encapsulates an idea of operation with the OD* resources.
@interface ODOperation : OperationWithSteps

/// A factory to create operations.
+ (instancetype)operationWithResource:(id<ODResource>)resource;

/// The way to get resource with which the operation is being performed.
@property (nonatomic) id<ODRetrieving> retrievalInfo;

/// Not all operations work for all kinds of resources. You should also override -validate;
+ (NSError *)errorForKind:(ODResourceKind)kind;

/// Check the operation's parameters.
- (NSError *)validate;


@end
