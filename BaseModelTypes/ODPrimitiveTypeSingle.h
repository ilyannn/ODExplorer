//
//  ODPrimitiveTypeSingle.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODPrimitiveTypeSingle : ODPrimitiveType

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj;
- (NSNumber *)valueForJSONString:(NSString *)obj;

@end
