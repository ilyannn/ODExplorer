//
//  OIDataService.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODService.h"
#import "ODCollection.h"
#import "ODBaseRequestManager.h"
#import "ODListEntitySetsOperation.h"

@implementation ODService

- (id)init {
    self = [super init];
    if (self) {
        self.kind = ODResourceKindCollection;
    }
    return self;
}

- (void)retrieve {
    ODListEntitySetsOperation *operation = [ODListEntitySetsOperation new];
    operation.resource = self;
    [self handleOperation:operation];
}

@end
