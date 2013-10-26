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

- (void)enqueueOperation:(ODOperation *)operation {
    
    __weak ODOperation *op = operation;
    operation.completionBlock = ^ {
        if (op.error) {
            NSLog(@"%@", op.error);
        }
    };
    
//    if (self.operationQueue)
    [self.operationQueue addOperation:operation];
//    else
//        [operation start];
}

- (void)retrieveEntity:(ODEntity *)entity {
    ODRetrieveOperation *operation = [ODRetrieveOperation new];
    operation.resource = entity;
    [self enqueueOperation:operation];
}

- (void)performAction:(NSString *)actionName for:(ODEntity *)entity withParameters:(NSDictionary *)params {
    ODActionOperation *operation = [ODActionOperation new];
    operation.resource = entity;
    operation.parameters = [params mutableCopy];
    operation.actionName = actionName;
    [self enqueueOperation:operation];
}

- (void)retrieveEntitySetsForService:(id)service {
    ODListEntitySetsOperation *operation = [ODListEntitySetsOperation new];
    operation.resource = service;
    [self enqueueOperation:operation];
}

- (void)retrieveCount:(ODCollection *)collection {
    ODCountOperation *operation = [ODCountOperation new];
    operation.resource = collection;
    [operation addOperationStep:^NSError *(ODCountOperation *operation) {
        collection.count = operation.responseCount;
        return nil;
    }];
    [self enqueueOperation:operation];
}

@end
