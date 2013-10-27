//
//  ODOperationWithSteps.m
//  OIDataNorth
//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OperationWithSteps.h"

@implementation OperationWithSteps {
    NSMutableArray *_userSteps;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self cleanOperationSteps];
        [self addCompletionBlock:^(id operation) {
            [operation cleanOperationSteps];
        }];
    }
    return self;
}

- (void)addOperationStep:(NSError *(^)(id))step {
    __weak id weakSelf = self;
    [_userSteps addObject: ^() {
        return step(weakSelf);
    }];
}

- (void)addCompletionBlock:(void (^)(id))added {
    __weak id weakSelf = self;
    void (^block)(void) = self.completionBlock;
    self.completionBlock = ^() {
        if (added) added (weakSelf);
        if (block) block();
    };
}

- (void)main {
    NSArray *all = [[self steps] arrayByAddingObjectsFromArray:_userSteps];
    self.error = [self performSteps:all];
}

- (NSArray *)steps {
    return @[];
}

/// Breaks the retain cycle in case self was strongly captured.
- (void)cleanOperationSteps {
    _userSteps = [NSMutableArray new];
}

- (NSError *)performSteps:(NSArray *)steps {
    __block NSError *error;
    [steps enumerateObjectsUsingBlock: ^(NSError * (^step)(), NSUInteger idx, BOOL *stop) {
        *stop = [self isCancelled] || (error = step());
    }];
    
    return error;
}

@end
