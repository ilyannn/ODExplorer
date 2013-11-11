//
//  ODMutableStructuredType.h
//  OIDataNorth
//
//  Created by ilya on 11/9/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODStructuredType.h"

@interface ODMutableStructuredType : ODStructuredType 

- (id)initWithName:(NSString *)name;
@property (readonly) NSString *name;
@property (readonly) NSMutableDictionary *properties;
@property (readonly) NSMutableArray *keyProperties;

@end
