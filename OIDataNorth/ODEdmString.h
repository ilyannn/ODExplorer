//
//  ODEdmString.h
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODEdmString : ODPrimitiveType

- (NSString *)valueForJSONString:(NSString *)obj;
- (NSString *)valueForJSONNumber:(NSNumber *)obj;

- (NSString *)JSONObjectForValue:(NSString *)value;

@end
