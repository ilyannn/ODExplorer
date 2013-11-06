//
//  ODCustomEntityType.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODStructuredType.h"

@interface ODCustomEntityType : ODStructuredType

@property (readwrite) NSString *entityClassName;
@property (readwrite) NSString *collectionClassName;

@end
