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
    NSURL *_knownURL;
    NSMutableDictionary *_localProperties;
    NSMutableDictionary *_remoteProperties;
}

// This is a designated initializer.
- (id)init {
    self = [super init];
    if (self) {
        self.kind = ODResourceKindEntity;
    }
    return self;
}

@synthesize localProperties = _localProperties;
@synthesize remoteProperties = _remoteProperties;


- (NSURL *)URL {
    if (_knownURL) {
        return _knownURL;
    }
    
    if (self.retrievalInfo) {
        return [self.retrievalInfo URL];
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
    if (self = [self init]) {
        [self updateFromDict:dict];
    }
    return self;
}

- (void)updateFromDict:(NSDictionary *)dict {
    _remoteProperties = [NSMutableDictionary new];
    _navigationProperties = [NSMutableDictionary new];
    [dict enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:NSDictionary.class]) {
            ODEntity *entity = [[ODEntity alloc] initFromDict:obj];
            ODRetrievalOfProperty *retrieval = [ODRetrievalOfProperty new];
            retrieval.parent = self.retrievalInfo;
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
    
    [[self.retrievalInfo readManager] retrieveProperty:key ofEntity:self];
    return self.localProperties[key];
}

- (void)retrieve {
    [[self.retrievalInfo readManager] retrieveEntity:self];
}

- (id)navigationProperty:(NSString *)name propertyType:(ODEntityType *)entityType {
    ODResource *result = self.navigationProperties[name];
    if (result) return result;
    
    ODEntity *target = [entityType createEntity];
    target.retrievalInfo.parent = self.retrievalInfo;
    
    ODRetrievalOfProperty *retrievalInfo = [ODRetrievalOfProperty new];
    retrievalInfo.parent = self.retrievalInfo;
    retrievalInfo.propertyName = name;
    
    target.retrievalInfo = retrievalInfo;
    return target;
}

- (id)navigationCollection:(NSString *)name entityType:(ODEntityType *)entityType {
    return [ODCollection collectionForProperty:name entityType:entityType inEntity:self];
}

- (NSString *)longDescription {
    return [@[[self description], [self.localProperties description]]
            componentsJoinedByString: @"\n"];
}

- (void)performAction:(NSString *)actionName {
    [self performAction:actionName withParameters:nil];
}

- (void)performAction:(NSString *)actionName withParameters:(NSDictionary *)params {
    NSAssert(self.kind != ODResourceKindCollection, @"Actions can't be performed on collections");
    [self.changeManager performAction:actionName for:self withParameters:params];
}

@end
