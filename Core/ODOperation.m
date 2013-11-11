//
//  OIDataQuery.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODOperation.h"
#import "ODOperationError+Parsing.h"


@implementation ODOperation

// This operation can be instantiated for any resourse.
+ (NSError *)errorForKind:(ODResourceKind)kind {
    return nil;
}

+ (instancetype)operationWithResource:(ODResource *)resource {
    if ([self errorForKind:resource.kind]) return nil;

    ODOperation *operation = [self new];
    operation.retrievalInfo = resource.retrievalInfo;
    return operation;
}

- (NSError *)validate {
    return nil;
}

- (NSArray *)steps {
    __weak id self_ = self;
    return @[ ^{ return [self_ validate]; }];
}



@end
