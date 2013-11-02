//
//  ODEntityType+Primitive.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODType+Primitive.h"

#import "ODEdmDateTime.h"
#import "ODEdmInt.h"
#import "ODEdmString.h"
#import "ODEdmBinary.h"
#import "ODEdmBoolean.h"
#import "ODEdmSByte.h"
#import "ODEdmGuid.h"

@implementation ODType (Primitive)

+ (NSArray *)listPrimitiveTypes {
    return @[
             [ODEdmDateTime new],
             [ODEdmInt withBits:16],
             [ODEdmInt withBits:32],
             [ODEdmInt withBits:64],
             [ODEdmString new],
             [ODEdmBoolean new],
             [ODEdmBinary new],
             [ODEdmSByte new],
             [ODEdmGuid new]
             ];
}

@end
