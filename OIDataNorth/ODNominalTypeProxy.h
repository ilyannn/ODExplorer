//
//  ODUnknownNamedType.h
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODNominalType.h"

@interface ODNominalTypeProxy : ODNominalType

- (instancetype)initWithName:(NSString *)name;
@property ODType *implementation;

@end
