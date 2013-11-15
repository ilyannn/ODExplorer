//
//  ODEntityType+Primitive.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODType+Primitive.h"

#import "ODPrimitiveTypeDateTime.h"
#import "ODPrimitiveTypeInt.h"
#import "ODPrimitiveTypeString.h"
#import "ODPrimitiveTypeBinary.h"
#import "ODPrimitiveTypeBoolean.h"
#import "ODPrimitiveTypeSByte.h"
#import "ODPrimitiveTypeGuid.h"
#import "ODPrimitiveTypeDecimal.h"
#import "ODPrimitiveTypeByte.h"
#import "ODPrimitiveTypeSingle.h"
#import "ODPrimitiveTypeDouble.h"

@implementation ODType (Primitive)

+ (NSSet *)allPrimitiveTypes {
    return [NSSet setWithArray: @[
             [ODPrimitiveTypeDateTime new],
             [ODPrimitiveTypeInt withBits:16],
             [ODPrimitiveTypeInt withBits:32],
             [ODPrimitiveTypeInt withBits:64],
             [ODPrimitiveTypeString new],
             [ODPrimitiveTypeBoolean new],
             [ODPrimitiveTypeBinary new],
             [ODPrimitiveTypeSByte new],
             [ODPrimitiveTypeGuid new],
             [ODPrimitiveTypeDecimal new],
             [ODPrimitiveTypeByte new],
             [ODPrimitiveTypeSingle new],
             [ODPrimitiveTypeDouble new],
             ]];
}

@end
