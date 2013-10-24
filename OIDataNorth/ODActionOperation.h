//
//  ODActionOperaion.h
//  OIDataNorth
//
//  Created by ilya on 10/23/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONOperation.h"

@interface ODActionOperation : ODJSONOperation

+ (instancetype)operationWithResource: (ODEntity *)entity;
@property ODEntity *resource;

@property NSString *actionName;

@end
