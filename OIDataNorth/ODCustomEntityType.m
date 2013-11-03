//
//  ODCustomEntityType.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCustomEntityType.h"

@implementation ODCustomEntityType

- (id)init {
    if (self = [super init]) {
        self.entityClassName = [super entityClassName];
        self.collectionClassName = [super collectionClassName];
    }
    return self;
}

@end
