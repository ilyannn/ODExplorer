//
//  ODElementType.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODType.h"

@interface ODNominalType : ODType

@property (readonly) NSString *name;
- (id)valueForJSONObject:(id)obj;

- (BOOL)isEqual:(id)object;

// Only primitive types have this.
- (NSString *)primitiveName;

@end
