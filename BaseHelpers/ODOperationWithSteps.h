//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// Operation whose main part can be represented as a series of steps.
/// Each step can cancel further processing by returning an error.
/// Steps can be added in subclasses by overriding -steps or on an instance by -addOperationStep:
@interface ODOperationWithSteps : NSOperation

/// Override this in subclasses instead of -main.
- (NSArray *)steps;

/// If a step returns error, it gets saved to this property.
@property (readonly) NSError *error;

// /// This gets called when error is returned, but before self.error is set.
// - (void)handleError:(NSError *)error onStep:(NSUInteger)step;

/// Adds an operation step. This takes a parameter self, so you don't need to capture any variables.
- (void)addLastOperationStep:(NSError * (^)(id op))step;

/// Insert an operation step at position 0.
- (void)addFirstOperationStep:(NSError * (^)(id op))step;

/// Completion block is similar to a step which is performed after operation's steps have been executed.
/// Therefore the completion step cannot return an error.
- (void)addCompletionBlock:(void (^)(id op))added;

/// Deletes user-defined steps. Deletes all steps if operation is finished or cancelled.
/// This is called automatially to break the retain cycle in case self was strongly captured by a block.
- (void)cleanOperationSteps;


@end
