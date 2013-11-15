//
//  ODMutableStructuredType.m
//  OIDataNorth
//
//  Created by ilya on 11/9/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODMutableStructuredType.h"
#import "ODStructuredType_Mutable.h"

@implementation ODMutableStructuredType 

- (instancetype)init {
    return [self initMutableWithName:nil];
}

- (instancetype)initWithName:(NSString *)name {
    return [super initMutableWithName:name];
}

@end
