//
//  OCOperation.m
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCOperation.h"
#import "OCChannel.h"

#define EXECUTING_KEYPATH @"isExecuting"

@interface OCOperation ()
@property (nonatomic) NSError *error;
@property NSOperationQueue *operationQueue;

@property (atomic, readwrite) BOOL isExecuting;
@property (atomic, readwrite) BOOL isFinished;

@property (readonly) NSUInteger currentIndex;

@end

@implementation OCOperation {
    NSMutableArray *_channels;
    NSMutableArray *_channelOperations;
}

- (id)init {
    if (self = [super init]) {
        _channels = [NSMutableArray new];
        _operationQueue = [NSOperationQueue new];
        _currentIndex = NSNotFound;
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
    self.isFinished = YES;
    self.isExecuting = NO;
}

- (NSOperationQueue *)queueFor:(OCChannel *)ch {
    return [ch requiresMainThread] ? [NSOperationQueue mainQueue] : _operationQueue;
}

- (BOOL)testCurrentChannelIndex {
    @synchronized (self) {
        return self.currentIndex == [_channels indexOfObjectPassingTest:^BOOL(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            return [obj isExecuting];
        }];
    }
}

- (void)start {
    self.isExecuting = YES;
    
    if ([self isCancelled]) {
        [self completeOperation];
        return;
    }

    _channelOperations = [[NSMutableArray alloc] initWithCapacity:_channels.count];
    [_channels enumerateObjectsUsingBlock:^(OCChannel *ch, NSUInteger idx, BOOL *stop) {
        ch.sendBlock = ^(id data, BOOL error) {
            @synchronized (self) {
                if (![self isCancelled]) {
                    if (error) {
                        _error = data;
                        [self cancel];
                    } else {
                        [self scheduleIndex:idx+1 with:data];
                    }
                }
            }
        };

        NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{ [ch setup]; }];
        [_channelOperations addObject:op];
        [[self queueFor:ch] addOperation: op];
    }];
    
    [self scheduleIndex:0 with:self.input];
}

- (void)scheduleIndex:(NSUInteger)index with:(id)input {
    OCChannel *ch = _channels[index];
    NSOperation *op = [ch operationWith:input];
    [op addDependency:_channelOperations[index]];
//    [op addObserver:self forKeyPath:EXECUTING_KEYPATH options:0 context:(NSInteger)];
    
    [[self queueFor:ch] addOperation: (_channelOperations[index] = op)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:EXECUTING_KEYPATH]) {
//        if ([object isExecuting] && _currentIndex < )
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
