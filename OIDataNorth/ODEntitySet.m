//
//  ODEntitySet.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntitySet.h"
#import "ODRetrievalInfo.h"

@implementation ODEntitySet

+ (instancetype)entitySetWithService:(ODService *)service name:(NSString *)name entityType:(ODEntityType *)entityType {
    ODRetrievalOfEntitySet * info = [ODRetrievalOfEntitySet new];
    info.parent = service.retrievalInfo;
    info.shortDescription = name;
    info.entitySetPath = name;

    ODEntitySet *entitySet = [self new];
    entitySet.retrievalInfo = info;
    entitySet.entityType = entityType;
    return entitySet;
}

@end
