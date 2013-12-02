//
//  OCChannel.m
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCChannel.h"

@implementation OCChannel 

#pragma mark - Things common to all channels

- (void)send:(id)data {
    if (self.sendBlock) {
        self.sendBlock(data, NO);
    }
}

- (void)error:(NSError *)error {
    if (self.sendBlock && error) {
        self.sendBlock(error, YES);
    }
}

- (NSOperation *)setUpOperation {
    return [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(setUp) object:nil];
}

- (NSOperation *)tearDownOperation {
    return [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(tearDown) object:nil];
}

// This is a synchronous operation.
- (NSOperation *)processOperationFor:(id)input {
    return [NSBlockOperation blockOperationWithBlock:^{
        NSError *error;
        @try {
            [self process:input];
        }
        @catch (NSException *exception) {
            error = [NSError errorWithDomain:OCErrorDomain code:kOCChannelErrorInternalException userInfo:nil];
        }
        if (error) [self error:error];
    }];
}

#pragma mark - Methods to override
- (BOOL)requiresMainThread {
    return NO;
}

- (NSString *)description {
    return @"Some channel";
}

- (NSString *)inputDescription {
    return @"anything";
}

- (NSString *)outputDescription {
    return @"void";
}

- (NSString *)fullDescription {
    return [NSString stringWithFormat:@"%@ : %@ -> %@", [self description], [self inputDescription], [self outputDescription]];
}

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)process:(id)input {

}


@end
