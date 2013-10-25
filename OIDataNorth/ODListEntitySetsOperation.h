//
//  ODListEntitySetsOperation.h
//  OIDataNorth
//
//  Created by ilya on 10/24/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONOperation.h"

@interface ODListEntitySetsOperation : ODJSONOperation

+ (instancetype)operationWithResource:(ODService *)service;
@property ODService *resource;

@end
