//
//  OSOperation.h
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OSOperationStep.h"

@interface OSOperation : NSOperation

/// Adds an operation step. This takes a parameter self, so you don't need to capture any variables.
- (void)addLastOperationStep:(OSOperationStep *)step;

/// Insert an operation step at position 0.
- (void)addFirstOperationStep:(OSOperationStep *)step;

@property (atomic, readonly) BOOL isExecuting;
@property (atomic, readonly) BOOL isFinished;

@end
