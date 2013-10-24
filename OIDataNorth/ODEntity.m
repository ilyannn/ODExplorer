//
//  OIDataEntry.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"
#import "ODCollection.h"
#import "ODEntityRetrieval.h"

@interface ODEntity ()
@property (nonatomic) NSMutableDictionary *localProperties;
@property (nonatomic) NSMutableDictionary *remoteProperties;
// @property (nonatomic) NSMutableDictionary *navigationProperties;
@end

@implementation ODEntity {
    NSDictionary *_keys;
    NSURL *_knownURL;
    NSMutableDictionary *_localProperties;
    NSMutableDictionary *_remoteProperties;
}

@synthesize localProperties = _localProperties;
@synthesize remoteProperties = _remoteProperties;

- (NSDictionary *)keys {
    return _keys;
}

- (void)setKeys:(id)keys {
    if ([keys isKindOfClass:NSString.class])
        _keys = @{ @"" : keys };
    else
        _keys = keys;
}

- (NSString *)relativePath {
    NSString *keyString = _keys[@""];
    if (!keyString) {
        NSMutableArray *keyStrings = [NSMutableArray new];
        for (NSString *property in _keys) {
            [keyStrings addObject:[NSString stringWithFormat:@"%@=%@", property, _keys[property]]];
        }
        keyString = [keyStrings componentsJoinedByString:@"&"];
    }
    //    return [NSString stringWithFormat:@"%@(%@)", , keyString];
    return nil;
}

- (NSURL *)URL {
    if (_knownURL) {
        return _knownURL;
    }
    
    if (self.retrievalInfo) {
        return [self.retrievalInfo retrievalURL];
    }
    
    return nil;
}

+ (ODEntityType *)entityType {
    //    static
    ODEntityType *_entityType;
    //   if (!_entityType) {
    _entityType = [ODEntityType new];
    _entityType.className = NSStringFromClass(self);
    //    }
    return _entityType;
}

- (ODEntityType *)entityType {
    return [self.class entityType];
}

- (id)initFromDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self updateFromDict:dict];
    }
    return self;
}

- (void)updateFromDict:(NSDictionary *)dict {
    _remoteProperties = [NSMutableDictionary new];
    _navigationProperties = [NSMutableDictionary new];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:NSDictionary.class]) {
            ODEntity *entity = [[ODEntity alloc] initFromDict:obj];
            ODEntityRetrievalByProperty *retrieval = [ODEntityRetrievalByProperty new];
            retrieval.fromEntity = self;
            retrieval.propertyName = key;
            entity.retrievalInfo = retrieval;
            _navigationProperties[key] = entity;
        } else {
            _remoteProperties[key] = obj;
        }
    }];
    
    _localProperties = [_remoteProperties mutableCopy];
}

- (id)valueForKey:(NSString *)key {
    id value = self.localProperties[key];
    if (value) return value;
    if (self.retrievedOn) return nil;
    
    [self.readManager retrieveProperty:key ofEntity:self];
    return self.localProperties[key];
}

- (void)retrieve {
    [self.readManager retrieveEntity:self];
}

- (id)navigationProperty:(NSString *)name propertyType:(ODEntityType *)entityType {
    ODResource *result = self.navigationProperties[name];
    if (result) return result;
    
    ODEntity *target = [entityType createEntity];
    target.parent = self;
    
    ODEntityRetrievalByProperty *retrievalInfo = [ODEntityRetrievalByProperty new];
    retrievalInfo.fromEntity = self;
    retrievalInfo.propertyName = name;
    
    target.retrievalInfo = retrievalInfo;
    return target;
}

- (id)navigationCollection:(NSString *)name entityType:(ODEntityType *)entityType {
    return [ODCollection collectionForProperty:name entityType:entityType inEntity:self];
}

- (void)performAction:(NSString *)actionName {
    [self performAction:actionName withParameters:nil];
}

- (void)performAction:(NSString *)actionName withParameters:(NSDictionary *)params {
    [self.changeManager performAction:actionName for:self withParameters:params];
}

- (NSString *)longDescription {
    return [@[[self description], [self.localProperties description]]
            componentsJoinedByString: @"\n"];
}

@end
