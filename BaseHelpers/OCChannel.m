//
//  OCChannel.m
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCChannel.h"

@implementation OCChannel

+ (Class)requiredInputClass {
    return nil;
}

+ (Class)requiredOutputClass {
    return nil;
}

- (void)send:(id)data {
    if (self.sendBlock) {
        self.sendBlock(data, NO);
    }
}

- (void)error:(NSError *)error {
    if (self.sendBlock) {
        self.sendBlock(error, YES);
    }
}

- (NSOperation *)operationWith:(id)input {
    return [NSBlockOperation blockOperationWithBlock:^{
        [self process:input];
    }];
}

- (void)process:(id)input {
    
}

- (BOOL)requiresMainThread {
    return NO;
}

- (NSString *)description {
    return @"A channel";
}

- (BOOL)validateInput:(id)input {
    Class class = [[self class] requiredInputClass];
    return !class || [input isKindOfClass:class];
}

- (BOOL)validateOutput:(id)output {
    Class class = [[self class] requiredOutputClass];
    return !class || [output isKindOfClass:class];
}


@end
