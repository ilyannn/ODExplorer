//
//  ODPrimitiveTypeDateTime.h
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODPrimitiveTypeDateTime : ODPrimitiveType

@property (readonly) id dateTimeFormatterV2;
@property (readonly) id dateTimeFormatterV3;

- (NSDate *)valueForJSONString:(NSString *)obj;
- (NSDate *)valueForJSONNumber:(NSNumber *)obj;

@end
