//
//  ODEdmDecimal.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEdmDecimal.h"

@implementation ODEdmDecimal

- (instancetype) init {
    return [super initWithName:@"Decimal"];
}

- (NSDecimalNumber *)valueForJSONNumber:(NSNumber *)obj {
    long long value = [obj longLongValue];
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithMantissa: value > 0 ? value : -value
                                                                 exponent:0
                                                               isNegative:(value > 0)];

    if ([obj isEqualToNumber:decimal])
        return decimal;
    
    return nil;
}

- (NSDecimalNumber *)valueForJSONString:(NSString *)obj {
    return [NSDecimalNumber decimalNumberWithString:obj];
}

- (NSString *)JSONObjectForValue:(NSDecimalNumber *)value {
    return [value stringValue];
}

@end
