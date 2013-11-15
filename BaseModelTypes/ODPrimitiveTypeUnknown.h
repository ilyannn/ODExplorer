//
//  ODPrimitiveTypeUnknown.h
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODPrimitiveTypeUnknown : ODPrimitiveType

- (id)valueForJSONString:(NSString *)obj;
- (NSNumber*)valueForJSONNumber:(NSNumber *)obj;

@end
