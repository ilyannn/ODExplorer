//
//  ODEntityType.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityType.h"

@implementation ODEntityType

- (ODEntity *)createEntity {
    return [self deserializeEntityFrom:nil];
}

- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict {
    return [[NSClassFromString(self.className) alloc] initFromDict:entityDict];
}

@end
