//
//  OSCustomStep.m
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OSBlockStep.h"

@implementation OSBlockStep {
    NSString *_description;
    BOOL _requiresMainThread;
    NSError * (^_step)(id op);
}

+ (instancetype)step:(NSString *)description withBlock:(NSError *(^)(id))block {
    return [[self alloc] initWithBlock:block description:description mainThread:NO];
}

+ (instancetype)mainThreadStep:(NSString *)description withBlock:(NSError *(^)(id))block {
    return [[self alloc] initWithBlock:block description:description mainThread:YES];
}

- (instancetype)initWithBlock:(NSError *(^)(id))block description:(NSString *)description mainThread:(BOOL)mainThread{
    if (self = [super init]) {
        _step = block;
        _description = description;
        _requiresMainThread = mainThread;
    }
    return self;
}

- (BOOL)requiresMainThread {
    return _requiresMainThread;
}

- (NSError *)perform:(id)op {
    return _step ? _step(op) : nil;
}

@end
