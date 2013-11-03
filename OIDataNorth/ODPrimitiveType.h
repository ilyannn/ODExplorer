//
//  ODEntityType.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODType.h"

@interface ODPrimitiveType : ODType

/// Designated initializer. Fills name from -primitiveName.
- (instancetype)init;
@property (readonly) NSString *primitiveName;

@property (readonly) NSString *className;

- (id)valueForJSONObject:(id)obj;

- (id)valueForJSONString:(NSString *)obj;
- (id)valueForJSONNumber:(NSNumber *)obj;

@end
