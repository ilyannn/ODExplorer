//
//  ODSimpleRequestManager.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBaseRequestManager.h"
#import "ODOperation.h"
#import "ODEntity.h"

@implementation ODBaseRequestManager

- (id)init {
    self = [super init];
    if (self) {
        self.propertyFaultStrategy = ODPropertyFaultReturn;
        self.propertyChangeStrategy = ODPropertyChangeIgnore;
        self.operationQueue = [NSOperationQueue new];
    }
    return self;
}

- (void)retrieveProperty:(NSString *)propertyName ofEntity:(id<ODEntity> *)entity {
    switch (self.propertyFaultStrategy) {
        case ODPropertyFaultReturn:
            // do nothing;
        default:
            break;
    }
}

- (BOOL)handleOperation:(ODOperation *)operation {
    [operation addCompletionBlock: ^ (ODOperation * op) {
        if (op.error) {
            NSLog(@"%@", op.error);
        }
    }];
    [self.operationQueue addOperation:operation];
    return YES;
}


@end
