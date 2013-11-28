//
//  OSOperationStep.m
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OSOperationStep.h"
#import "OSBlockStep.h"

@implementation OSOperationStep

+ (OSOperationStep *)step:(NSString *)description withBlock:(NSError *(^)(id))block {
    return [OSBlockStep step:description withBlock:block];
}

+ (OSOperationStep *)mainThreadStep:(NSString *)description withBlock:(NSError *(^)(id))block {
    return [OSBlockStep mainThreadStep:description withBlock:block];
}

- (BOOL)requiresMainThread {
    return NO;
}

- (NSString *)description {
    return @"An operation step";
}

- (NSError *)perform:(id)op {
    return nil;
}

- (void)breakRetainCycles {
    
}

@end
