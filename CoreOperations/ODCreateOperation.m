//
//  ODCreateOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/30/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCreateOperation.h"
#import "ODOperationError+Parsing.h"

@implementation ODCreateOperation

+ (NSError *)errorForKind:(ODResourceKind)kind {
    ODAssertOperation(kind == ODResourceKindEntity, @"You can only create an entity.");
    return nil;
}

- (NSArray *)steps {
    return @[];
}


@end
