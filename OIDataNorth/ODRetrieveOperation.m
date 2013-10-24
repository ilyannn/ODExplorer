//
//  ODRetrieveOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrieveOperation.h"
#import "ODEntity.h"

@implementation ODRetrieveOperation

+ (instancetype)operationWithResource:(ODEntity *)entity {
    return [super operationWithResource:entity];
}

- (void)processJSONResponse:(id)response {
    if (!response) return;
    if (![response isKindOfClass:NSDictionary.class]) return;

    [self.resource updateFromDict:response];
}

@end
