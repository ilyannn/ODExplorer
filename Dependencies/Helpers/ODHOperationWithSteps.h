//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Operation whose main part can be represented as a series of steps.
/// Each step can cancel further processing by returning an error.
/// Steps can be added in subclasses by overriding -steps or on an instance by -addOperationStep:
@interface ODHOperationWithSteps : NSOperation

/// Override this in subclasses instead of -main.
- (NSArray *)steps;

/// Adds an operation step. This takes a parameter self, so you don't need to capture any variables.
- (void)addOperationStep:(NSError * (^)(id op))step;

/// If a step returns error, it gets saved to this property.
@property (readonly) NSError *error;

/// This gets called when error is set.
- (NSError *)handleError:(NSError *)error onStep:(NSUInteger)step;

/// Deletes user-defined steps. Deletes all steps if operation is finished or cancelled.
/// This is called automatially to break the retain cycle in case self was strongly captured by a block.
- (void)cleanOperationSteps;

/// Completion block is essentially a step which is performed after operation has been finished.
/// Therefore the completion step cannot return an error.
- (void)addCompletionBlock:(void (^)(id op))added;

@end
