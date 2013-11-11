//
//  ODNotifyingManager.m
//  OIDataNorth
//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNotifyingManager.h"
#import "ODOperation.h"

@interface ODNotifyingManager ()
@end

@implementation ODNotifyingManager

- (id)init {
    self = [super init];
    if (self) {
        _currentOperations = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    }
    return self;
}

- (instancetype)initWithDelegate:(id <ODNotifyingManagerDelegate> )delegate {
    self = [self init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (BOOL)hasOperations {
    return !!_currentOperations.count;
}

- (BOOL)handleOperation:(ODOperation *)operation {
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
        [self.delegate manager:self willStart:operation];
        
        BOOL update = !self.hasOperations;
        if (update) [self willChangeValueForKey:@"hasOperations"];
        [self.currentOperations addObject:operation];
        if (update) {
            [self didChangeValueForKey:@"hasOperations"];
        }
    }];
    
    [operation addCompletionBlock: ^(ODOperation *op) {
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            BOOL update = (self.currentOperations.count == 1 && [self.currentOperations containsObject:op]);
            if (update) [self willChangeValueForKey:@"hasOperations"];
            [self.currentOperations removeObject:op];
            if (update) {
                [self didChangeValueForKey:@"hasOperations"];
            }
            
            [self.delegate manager:self didFinish:op];
        }];
    }];
    
    return NO;
}

@end
