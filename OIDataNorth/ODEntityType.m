//
//  ODEntityType.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityType.h"
#import "ODEntity.h"
#import "ODCollection.h"

@implementation ODEntityType {
    NSString *_name;
}

- (id)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
        _properties = [NSMutableDictionary new];
        _keyProperties = [NSMutableArray new];
    }
    return self;
}

- (NSString *)name {
    return _name;
}

- (ODEntity *)entityWithInfo:(id)info {
    ODEntity * entity = [NSClassFromString(self.entityClassName) resourceWithInfo:info];
    entity.type = self;
    return entity;
}

- (NSString *)entityClassName {
    return @"ODEntity";
}

- (NSString *)collectionClassName {
    return @"ODCollection";
}

- (ODEntity *)deserializeEntityFrom:(NSDictionary *)entityDict
                           withInfo:(id<ODRetrieving>)info {
    ODEntity *entity = [self entityWithInfo:info];
    entity.type = self;
    return [entity parseFromJSONDictionary:entityDict] ? nil : entity;
}

- (ODCollection *)deserializeCollectionFromArray:(NSArray *)collectionArray
                                        withInfo:(id<ODRetrieving>)info {
    ODCollection *collection = [ODCollection resourceWithInfo:info];
    collection.type = self;
//    return [collection parseFromJSONArray:collectionArray] ? nil : collection;
    return nil;
}


@end
