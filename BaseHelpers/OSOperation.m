//
//  OSOperation.m
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OSOperation.h"

@interface OSOperation ()
@property (atomic) NSMutableArray *allSteps;
@property (nonatomic) NSError *error;
@property NSOperationQueue *operationQueue;

@property NSInteger currentStepIndex;

@property (readwrite, getter = isExecuting) BOOL executing;
@property (readwrite, getter = isFinished) BOOL finished;

@end

@implementation OSOperation

- (id)init {
    if (self = [super init]) {
        self.currentStepIndex = NSNotFound;
        self.allSteps = [NSMutableArray new];
    }
    return self;
}

- (void)addFirstOperationStep:(OSOperationStep *)step {
    [self.allSteps insertObject:step atIndex:0];
}

- (void)addLastOperationStep:(OSOperationStep *)step {
    [self.allSteps addObject:step];
}

- (NSString *)description {
    NSInteger index = self.currentStepIndex;
    NSString *status = (index == NSNotFound) ? nil : [NSString stringWithFormat:@"step %ld of %lu \"%@\"",
                                                      (long)index, (unsigned long)self.allSteps.count,
                                                      [self.allSteps[index] description]
                  ];

    if (self.finished && !!self.error) {
        status = [NSString stringWithFormat:@"finished with error %@ on %@", self.error, status];
    } else if (self.finished && !self.error) {
        status = @"finished without errors";
    } else if (self.executing) {
        status = [NSString stringWithFormat:@"executing %@", status];
    } else {
        status = @"has not stated yet";
    }
    return [NSString stringWithFormat:@"%@, current status:%@", [super description], status];
}

- (void)completeOperation {

    self.finished = YES;
    self.executing = NO;
    self.currentStepIndex = NSNotFound;

    // Drop strongly captured variables, if any.
    self.allSteps = nil;
}

- (void)start {

    self.executing = YES;

    if ([self isCancelled]) {
        [self completeOperation];
        return;
    }
    
    NSUInteger count = self.allSteps.count;
    NSOperationQueue *backgroundQueue = [NSOperationQueue new];
    
    // Iterate over self.allSteps + last step.
    NSOperation *current, *previous;
    for (NSUInteger index = 0; index <= count; index++, previous = current) {
        
        OSOperationStep *step = (index == count) ? nil : self.allSteps[index];
        NSOperationQueue *queue = [step requiresMainThread] ? [NSOperationQueue mainQueue] : backgroundQueue;
        
        if (!step) {
            // Last step = complete this operation.
            current = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(completeOperation) object:nil];
            
        } else {
            // Schedule a normal step.

            current = [NSBlockOperation blockOperationWithBlock:^{
                
                self.currentStepIndex = index;
                
                if ([self isCancelled]) {
                    return;
                }
                
                if ((self.error = [step perform:self])) {
                    [self cancel];
                }
                
            }];
        }
        
        if (previous) [current addDependency:previous];
        [queue addOperation:current];
    }
}


@end
