//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperationWithSteps.h"

@interface ODOperationWithSteps ()
@property (atomic) NSMutableArray *allSteps;
@property (nonatomic) NSError *error;
@end

@implementation ODOperationWithSteps

#pragma mark - NSOperation

- (NSString *)description {
    return NSStringFromClass([self class]);
}

- (void)main {
    [self performSteps:self.allSteps];
    [self cleanOperationSteps];
}


- (void)cancel {
    [self cleanOperationSteps];
    [super cancel];
}

#pragma mark - Configuration

- (id)init {
    self = [super init];
    
    if (self) {
        [self cleanOperationSteps];
    }
    
    return self;
}

- (void)addLastOperationStep:(NSError *(^)(id))step {
    if (![self isExecuting]) {
        __weak id weakSelf = self;
        [self.allSteps addObject: ^ {
            return step(weakSelf);
        }];
    }
}

- (void)addFirstOperationStep:(NSError *(^)(id))step {
    if (![self isExecuting]) {
        __weak id weakSelf = self;
        [self.allSteps insertObject: ^ {
            return step(weakSelf);
        } atIndex:0];
    }
}

- (void)addCompletionBlock:(void (^)(id))added {
    __weak id weakSelf = self;
    void (^block)(void) = self.completionBlock;
    
    self.completionBlock = ^ {
        if (added) added(weakSelf);
        if (block) block();
    };
}


#pragma mark - Running 

- (void)cleanOperationSteps {
    self.allSteps = ([self isFinished] || [self isCancelled]) ? nil : [[self steps] mutableCopy];
}

- (void)performSteps:(NSArray *)steps {
    [steps enumerateObjectsUsingBlock: ^(NSError * (^step)(), NSUInteger idx, BOOL *stop) {
        *stop = [self isCancelled] || !!(self.error = step());
    }];
}

/// This method is to be overridden.
- (NSArray *)steps {
    return @[];
}


@end
