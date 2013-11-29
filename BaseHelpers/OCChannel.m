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
    if (self.sendBlock) {
        self.sendBlock(error, YES);
    }
}


#pragma mark - Validation
+ (Class)requiredInputClass {
    return nil;
}

+ (Class)requiredOutputClass {
    return nil;
}

- (BOOL)validateInput:(id)input {
    Class class = [[self class] requiredInputClass];
    return !class || [input isKindOfClass:class];
}

- (BOOL)validateOutput:(id)output {
    Class class = [[self class] requiredOutputClass];
    return !class || [output isKindOfClass:class];
}

#pragma mark - Methods to override
- (BOOL)requiresMainThread {
    return NO;
}

- (void)setup {
    
}

- (void)teardown {
    
}

- (NSString *)description {
    return @"A channel";
}

- (void)process:(id)input {
    
}


@end
