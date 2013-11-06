//
//  ODEntityType.h
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNominalType.h"

/// Types that are declared in OData specification.
@interface ODPrimitiveType : ODNominalType

@property (readonly) NSString *primitiveName;
@property (readonly) NSString *className;

/// Parse a JSON object into primitive value.
- (id)valueForJSONObject:(id)obj;

/// Method to override: parsing from JSON string.
- (id)valueForJSONString:(NSString *)obj;

/// Method to override: parsing from JSON number.
- (id)valueForJSONNumber:(NSNumber *)obj;

/// Serialize value into a JSON object.
- (id)JSONObjectForValue:(id)obj;


@end
