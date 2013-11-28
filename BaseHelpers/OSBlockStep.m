//
//  OSCustomStep.m
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OSBlockStep.h"

@interface OSBlockStep ()
@property (strong, atomic) OSBlockType step;

@end

@implementation OSBlockStep {
    NSString *_description;
    BOOL _requiresMainThread;
}

+ (instancetype)step:(NSString *)description withBlock:(OSBlockType)block {
    return [[self alloc] initWithBlock:block description:description mainThread:NO];
}

+ (instancetype)mainThreadStep:(NSString *)description withBlock:(OSBlockType)block {
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

- (void)breakRetainCycles {
    _step = NULL;
}

@end
