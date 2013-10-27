//
//  ODSimpleRequestManager.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBaseRequestManager.h"

#import "ODRetrieveOperation.h"
#import "ODActionOperation.h"
#import "ODListEntitySetsOperation.h"
#import "ODCountOperation.h"
#import "ODCollection.h"

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

- (void)retrieveProperty:(NSString *)propertyName ofEntity:(ODEntity *)entity {
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
            // Set the BREAKPOINT here to debug operation failures.
            NSLog(@"%@", op.error);
        }
    }];
    [self.operationQueue addOperation:operation];
    return YES;
}


@end
