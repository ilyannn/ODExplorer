//
//  ODEntityType.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityType.h"
#import "ODEntity.h"
#import "ODCollection.h"
#import "ODResource+Entity.h"
#import "ODResource+Collection.h"

@implementation ODEntityType

- (ODEntity *)entityWithInfo:(id)info {
    return [NSClassFromString(self.className) resourceWithInfo:info];
}

- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict
                         withInfo:(id<ODRetrieving>)info {
    ODEntity *entity = [self entityWithInfo:info];
    entity.entityType = self;
    return [entity parseFromJSONDictionary:entityDict] ? nil : entity;
}

- (ODCollection *)deserializeCollectionFromArray:(NSArray *)collectionArray
                           withInfo:(id<ODRetrieving>)info {
    ODCollection *collection = [ODCollection resourceWithInfo:info];
    collection.entityType = self;
    return [collection parseFromJSONArray:collectionArray] ? nil : collection;
}

@end
