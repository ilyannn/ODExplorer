//
//  OCOperation.m
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCOperation.h"
#import "OCChannel.h"

NSString * const OCChannelErrorDomain = @"com.ilya.OC";

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
        _operationQueue.name = OCChannelErrorDomain;
    }
    return self;
}

- (NSArray *)channels {
    return [_channels copy];
}

- (void)addInputChannel:(OCChannel *)ch {
    @synchronized(self) {
        if ([self isExecuting]) {
            [NSException raise:@"Cannot add a channel at index 0"
                        format:@"Operation %@ is already being executed", self];
        }
        [_channels insertObject:ch atIndex:0];
    }
}

- (void)addOutputChannel:(OCChannel *)ch {
    @synchronized (self) {
        if ([self isFinished]) {
            [NSException raise:@"Cannot add a channel at the last index"
                        format:@"Operation %@ is already finished", self];
        }
        [_channels addObject:ch];
    }
}

- (NSString *)description {
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
    
    NSString *inputDescription = _channels.count ? [_channels.firstObject inputDescription] : @"(empty)";
    NSString *outputDescription = _channels.count ? [_channels.lastObject outputDescription] : @"(empty)";
    
    return [NSString stringWithFormat:@"%@ : %@ -> %@ with channels: %@ has current status:%@",
            [super description], inputDescription, outputDescription, _channels, status];
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

- (NSUInteger)tornDownCount {
    @synchronized (self) {
        return [_teardownOperations indexOfObjectPassingTest:^BOOL(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            return ![obj isFinished] || idx == _teardownOperations.count - 1;
        }];
    }
}

- (NSError *)synchronouslyPerformFor:(id)input {
    self.input = input;
    [self start];
    [self waitUntilFinished];
    return self.error;
}

- (void)start {
    @synchronized(self) {
        NSAssert(![self isExecuting] && ![self isFinished], @"Operation cannot be re-started!");

        self.isExecuting = YES;
        
        if ([self isCancelled]) {
            [self completeOperation];
            return;
        }
        
        _currentOperations = [[NSMutableArray alloc] initWithCapacity:_channels.count];
        _teardownOperations = [[NSMutableArray alloc] initWithCapacity:_channels.count];

        // Start with defining setup and teardown operations. Also add setup operations.
        [_channels enumerateObjectsUsingBlock:^(OCChannel *ch, NSUInteger index, BOOL *stop) {
            ch.sendBlock = [self sendBlockFor:ch atIndex:index];
            _teardownOperations[index] = [ch tearDownOperation];
            [[self queueFor:ch] addOperation:(_currentOperations[index] = [ch setUpOperation])];
        }];
        
        // There is also a special operation that finishes current operation.
        [_teardownOperations addObject:[[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(completeOperation)
                                                                              object:nil]];

        // Teardown operations occur from first to last channel + special.
        for (NSInteger index = 0; index < _channels.count; index++) {
            [_teardownOperations[index + 1] addDependency:_teardownOperations[index]];
        }
        
        // Inject operation with input into dependencies.
        [self scheduleIndex:0 with:self.input];

        // Insert teardown operations last, or they will be executed immediately.
        [_teardownOperations enumerateObjectsUsingBlock:^(NSOperation *obj, NSUInteger idx, BOOL *stop) {
            [(idx == _channels.count ? _operationQueue : [self queueFor:_channels[idx]]) addOperation:obj];
        }];
    }
}

- (void)setError:(NSError *)error {
    if (error != _error) {
        _error = error;
        if (error && [self isExecuting] && ![self isCancelled]) {
            [self cancel];
        }
    }
}

- (void(^)(id, BOOL))sendBlockFor:(OCChannel *)ch atIndex:(NSUInteger)index {
    return  ^(id data, BOOL error) {
        @synchronized (self) {
            if (![self isCancelled]) {
                if (error) {
                    self.error = data;
                } else {
                    [self scheduleIndex:index+1 with:data];
                }
            }
        }
    };
}

- (void)cancel {
    [super cancel];
    if (!self.error) {
        self.error = [NSError errorWithDomain:OCChannelErrorDomain
                                         code:kOCOperationWasCanceled
                                     userInfo:nil];
    }
}

- (void)scheduleIndex:(NSUInteger)index with:(id)input {
    if (index == _channels.count) {
        // last channel's output
        
        [self output:input];
    
    } else {
        
        OCChannel *ch = _channels[index];
        NSOperation *op = [ch processOperationFor:input];
        
        [op addDependency:_currentOperations[index]];
        [_teardownOperations[index] addDependency:op];
        
        _currentOperations[index] = op;
        [[self queueFor:ch] addOperation: op];
    }
}

- (void)output:(id)output {
    self.error = [NSError errorWithDomain:OCChannelErrorDomain code:kOCChannelErrorUnexpectedOutput
                                 userInfo:@{@"output":output}];
}

@end
