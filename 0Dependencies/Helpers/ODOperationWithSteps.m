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
        [self.allSteps addObject: ^() {
            return step(weakSelf);
        }];
    }
}

- (void)addFirstOperationStep:(NSError *(^)(id))step {
    if (![self isExecuting]) {
        __weak id weakSelf = self;
        [self.allSteps insertObject: ^() {
            return step(weakSelf);
        } atIndex:0];
    }
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
    [self performSteps:self.allSteps];
    [self cleanOperationSteps];
}

/*- (void)handleError:(NSError *)error onStep:(NSUInteger)step {
 NSLog(@"Operation %@ has reported on step %lu/%lu: %@", self, (unsigned long)step, (unsigned long)[_allSteps count], error);
 return !!error;
 }
 */

- (NSString *)description {
    return NSStringFromClass([self class]);
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

- (void)performSteps:(NSArray *)steps {
    [steps enumerateObjectsUsingBlock: ^(NSError * (^step)(), NSUInteger idx, BOOL *stop) {
        *stop = [self isCancelled] && !!(self.error = step());
    }];
}

@end
