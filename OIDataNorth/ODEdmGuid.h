//
//  ODEdmGuid.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"

@interface ODEdmGuid : ODPrimitiveType

- (NSUUID *)valueForJSONString:(NSString *)obj;

@end
