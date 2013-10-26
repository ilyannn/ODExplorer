//
//  ODEntitySet.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntitySet.h"

@implementation ODEntitySet

+ (instancetype)entitySetWithService:(ODService *)service name:(NSString *)name entityType:(ODEntityType *)entityType {
    ODEntitySet *entitySet = [self new];
    entitySet.retrievalInfo = [ODRetrievalInfo new];
    entitySet.retrievalInfo.parent = service.retrievalInfo;
    entitySet.name = name;
    entitySet.entityType = entityType;
    return entitySet;
}

- (NSString *)shortDescription {
    return self.name;
}

@end
