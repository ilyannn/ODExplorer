//
//  ODContext.m
//  ODExplorerLib
//
//  Created by ilya on 11/14/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManager.h"

@implementation ODManager

static ODManager *_shared;

+ (instancetype)sharedManager {
    return _shared;
}

+ (void)setSharedManager:(ODManager *)context {
    _shared = context;
}

- (void)handleOperation:(ODOperation *)operation {
    if ([self willHandle: operation]) {
        [self.parentManager handleOperation:operation];
        [self didHandle: operation];
    }
}

- (BOOL)willHandle:(ODOperation *)operation {
    return YES;
}

- (void)didHandle:(ODOperation *)operation {
    
}

@end
