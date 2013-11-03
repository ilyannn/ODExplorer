//
//  ODPrimitiveTypeInt.h
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODPrimitiveTypeInt : ODPrimitiveType
@property (readonly) NSUInteger bits;

+ (instancetype)withBits:(NSUInteger)bits;
- (instancetype)initWithBits:(NSUInteger)bits;

- (NSNumber *)valueForJSONString:(NSString *)obj;
- (NSNumber *)valueForJSONNumber:(NSNumber *)obj;

@end
