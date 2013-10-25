//
//  ODEntityType.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityType.h"
#import "ODEntity.h"

@implementation ODEntityType

- (ODEntity *)createEntity {
    return [self deserializeEntityFrom:nil];
}

- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict {
    ODEntity *entity = [NSClassFromString(self.className) alloc];
    return [entity initFromDict:entityDict];
}

@end
