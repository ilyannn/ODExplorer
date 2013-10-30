//
//  ODOperationWithSteps.m
//  OIDataNorth
//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OperationWithSteps.h"

@interface OperationWithSteps ()
@property (atomic) NSMutableArray *allSteps;
@end

@implementation OperationWithSteps

- (id)init
{
    self = [super init];

    if (self) {
        [self cleanOperationSteps];
    }

    return self;
}

- (void)addOperationStep:(NSError *(^)(id))step {
    __weak id weakSelf = self;
    [self.allSteps addObject: ^() {
        return step(weakSelf);
    }];
}

- (void)addCompletionBlock:(void (^)(id))added {
    __weak id weakSelf = self;
    void (^block)(void) = self.completionBlock;
    
    self.completionBlock = ^() {
        if (added) added(weakSelf);
        if (block) block();
    };
}

- (void)main {
    _error = [self performSteps:self.allSteps];
    [self cleanOperationSteps];
}

- (void)cancel {
    [self cleanOperationSteps];
    [super cancel];
}

- (NSArray *)steps {
    return @[];
}

- (void)cleanOperationSteps {
    self.allSteps = ([self isFinished] || [self isCancelled]) ? nil : [[self steps] mutableCopy];
}

- (NSError *)performSteps:(NSArray *)steps {
    __block NSError *error;
    [steps enumerateObjectsUsingBlock: ^(NSError * (^step)(), NSUInteger idx, BOOL *stop) {
        *stop = [self isCancelled] || !!(error = step());
    }];

    return error ;
}


@end
