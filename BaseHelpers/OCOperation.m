//
//  OCOperation.m
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCOperation.h"
#import "OCChannel.h"

// #import "MAKVONotificationCenter.h"

#define FINISHED_KEYPATH @"isFinished"

@interface OCOperation ()
@property (nonatomic) NSError *error;
@property NSOperationQueue *operationQueue;

@property (atomic, readwrite) BOOL isExecuting;
@property (atomic, readwrite) BOOL isFinished;

@end

@implementation OCOperation {
    NSMutableArray *_channels;
    NSMutableArray *_currentOperations;
    NSMutableArray *_teardownOperations;
}

- (id)init {
    if (self = [super init]) {
        _channels = [NSMutableArray new];
        _operationQueue = [NSOperationQueue new];
        _operationQueue.name = [NSString stringWithFormat:@"com.ilya.%@", [OCOperation class]];
    }
    return self;
}

- (NSArray *)channels {
    return [_channels copy];
}

- (void)addFirstChannel:(OCChannel *)ch {
    @synchronized(self) {
        if ([self isExecuting]) {
            [NSException raise:@"Cannot add a channel at index 0"
                        format:@"Operation %@ is already being executed", self];
        }
        [_channels insertObject:ch atIndex:0];
    }
}

- (void)addLastChannel:(OCChannel *)ch {
    @synchronized (self) {
        if ([self isFinished]) {
            [NSException raise:@"Cannot add a channel at the last index"
                        format:@"Operation %@ is already finished", self];
        }
        [_channels addObject:ch];
    }
}

- (NSString *)description {
    /*    NSString *status = (index == NSNotFound) ? nil : [NSString stringWithFormat:@"step %ld of %lu \"%@\"",
     (long)index, (unsigned long)self.allSteps.count,
     [self.allSteps[index] description]
     ];
     */
    NSString *status;
    if ([self isFinished] && !!self.error) {
        status = [NSString stringWithFormat:@"finished with error %@", self.error];
    } else if ([self isFinished] && !self.error) {
        status = @"finished without errors";
    } else if ([self isExecuting]) {
        status = [NSString stringWithFormat:@"executing"];
    } else {
        status = @"has not stated yet";
    }
    return [NSString stringWithFormat:@"%@, current status:%@", [super description], status];
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)completeOperation {
    [self willChangeValueForKey:FINISHED_KEYPATH];
    self.isFinished = YES;
    [self didChangeValueForKey:FINISHED_KEYPATH];
    self.isExecuting = NO;
}

- (NSOperationQueue *)queueFor:(OCChannel *)ch {
    return [ch requiresMainThread] ? [NSOperationQueue mainQueue] : _operationQueue;
}

- (NSUInteger)tearedDownCount {
    @synchronized (self) {
        return [_teardownOperations indexOfObjectPassingTest:^BOOL(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            return ![obj isFinished] || idx == _teardownOperations.count - 1;
        }];
    }
}

- (void)start {
    @synchronized(self) {
        self.isExecuting = YES;
        
        if ([self isCancelled]) {
            [self completeOperation];
            return;
        }

        [_operationQueue setSuspended:YES];
        
        _currentOperations = [[NSMutableArray alloc] initWithCapacity:_channels.count];
        _teardownOperations = [[NSMutableArray alloc] initWithCapacity:_channels.count];

        // Start with defining setup and teardown operations.
        [_channels enumerateObjectsUsingBlock:^(OCChannel *ch, NSUInteger index, BOOL *stop) {
            ch.sendBlock = [self sendBlockFor:ch atIndex:index];
            _currentOperations[index] = [[NSInvocationOperation alloc] initWithTarget:ch selector:@selector(setup) object:nil];
            _teardownOperations[index] = [[NSInvocationOperation alloc] initWithTarget:ch selector:@selector(teardown) object:nil];
        }];
        
        // There is also a special operation that finishes current operation.
        [_teardownOperations addObject:[[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(completeOperation)
                                                                              object:nil]];

        // Now add operations to the suspended queue.
        [_operationQueue addOperations:_currentOperations waitUntilFinished:NO];
        [_operationQueue addOperations:_teardownOperations waitUntilFinished:NO];

        // Setup operations occur from last to first channel.
        for (NSInteger index = 1; index < _currentOperations.count; index++) {
            [_currentOperations[index-1] addDependency:_currentOperations[index]];
        }
        
        // Teardown operations occur from first to last channel + special.
        for (NSInteger index = 1; index < _teardownOperations.count; index++) {
            [_teardownOperations[index] addDependency:_teardownOperations[index-1]];
        }
        
        // Inject first operation into dependencies.
        [self scheduleIndex:0 with:self.input];
        
        // And go!
        [_operationQueue setSuspended:NO];
    }
}

- (void(^)(id, BOOL))sendBlockFor:(OCChannel *)ch atIndex:(NSUInteger)index {

    return  ^(id data, BOOL error) {
        @synchronized (self) {
    
            if (![self isCancelled]) {
                if (error) {
                    _error = data;
                    [self cancel];
                } else {
                    [self scheduleIndex:index+1 with:data];
                }
            }
            
        }
    };
    

}

- (void)scheduleIndex:(NSUInteger)index with:(id)input {
    // last channel's output is ignored
    if (index == _channels.count) {
        return;
    }
    
    OCChannel *ch = _channels[index];
    NSOperation *op = [[NSInvocationOperation alloc] initWithTarget:ch selector:@selector(process:) object:input];
    
    [op addDependency:_currentOperations[index]];
    [_teardownOperations[index] addDependency:op];
    
     _currentOperations[index] = op;
    [[self queueFor:ch] addOperation: op];
}

@end
