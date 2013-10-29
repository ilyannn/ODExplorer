//
//  ODOperationWithSteps.h
//  OIDataNorth
//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// Operation which main part can be represented as a series of steps.
/// Each step can cancel further processing by returning error, saved to self.error.
/// Steps can be added in subclasses or manually by -addOperationStep:
@interface OperationWithSteps : NSOperation

/// Override this in subclasses instead of -main.
- (NSArray *)steps;

@property (readonly) NSError *error;

/// Adds an operation step. This takes a parameter self, so you don't need to capture any variables.
- (void)addOperationStep:(NSError * (^)(id operation))step;

/// Deletes user-defined steps. Deletes all steps if operation is finished or cancelled.
/// This is called automatially to break the retain cycle in case self was strongly captured.
- (void)cleanOperationSteps;

/// Completion block is essentially a step which is performed after operation has been finished.
/// Therefore they cannot return an error.
- (void)addCompletionBlock:(void (^)(id operation))added;


@end
