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

- (ODEntity *)entityWithInfo:(id)info {
    return [NSClassFromString(self.className) resourceWithInfo:info];
}

- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict
                         withInfo:(id<ODRetrieving>)info {
    ODEntity *entity = [self entityWithInfo:info];
    [entity updateFromDict:entityDict];
    return entity;
}

@end
