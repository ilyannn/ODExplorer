//
//  ODPrimitiveTypeSByte.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeSByte.h"

@implementation ODPrimitiveTypeSByte

- (NSString *)primitiveName {
    return @"SByte";
}

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

@end
