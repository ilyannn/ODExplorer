//
//  ODEdmDecimal.h
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODEdmDecimal : ODPrimitiveType

- (NSDecimalNumber *)valueForJSONNumber:(NSNumber *)obj;
- (NSDecimalNumber *)valueForJSONString:(NSString *)obj;
- (NSString *)JSONObjectForValue:(NSDecimalNumber *)value;

@end
