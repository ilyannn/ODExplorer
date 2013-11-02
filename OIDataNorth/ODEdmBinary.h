//
//  ODEdmBinary.h
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODEdmBinary : ODPrimitiveType

- (NSData *)valueForJSONString:(NSString *)obj;

@end
