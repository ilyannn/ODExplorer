//
//  OIDataEntry.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntity.h"
#import "ODCollection.h"
#import "ODResource_Internal.h"

#import "ODRetrieving_Objects.h"
#import "ODRetrieveOperation.h"
#import "ODActionOperation.h"

#import "ODCustomEntityType.h"

@implementation ODEntity

// This is a designated initializer.
- (id)init {
    self = [super init];
    if (self) {
        self.kind = ODResourceKindEntity;
    }
    return self;
}

- (instancetype)initFromDict:(NSDictionary *)dict parentInfo:(id <ODRetrieving> )parentInfo {
    ODRetrieveBase *info;
    return [self initWithRetrievalInfo:info];
}

+ (ODCustomEntityType *)customEntityType {
    ODCustomEntityType *entityType = [ODCustomEntityType new];
    entityType.entityClassName = NSStringFromClass(self);
    return entityType;
}

- (id)valueForKey:(NSString *)key {
    id value = self.localProperties[key];
    if (value) return value;
//    if (self.retrievedOn) return nil;
    
    //    [[self.retrievalInfo readManager] retrieveProperty:key ofEntity:self];
    return self.localProperties[key];
}

- (id)navigationProperty:(NSString *)name propertyType:(ODType *)entityType {
    ODResource *result = self.navigationProperties[name];
    if (result) return result;
    
    //    target.retrievalInfo.parent = self.retrievalInfo;
    
    ODRetrievalOfProperty *retrievalInfo = [ODRetrievalOfProperty new];
    retrievalInfo.parent = self.retrievalInfo;
    retrievalInfo.propertyName = name;
    
//    return [self.entityType entityWithInfo:retrievalInfo];
    return nil;
}

/*- (id)navigationCollection:(NSString *)name entityType:(ODEntityType *)entityType {
    return [ODCollection collectionForProperty:name entityType:entityType inEntity:self];
}
*/


- (void)performAction:(NSString *)actionName {
    [self performAction:actionName withParameters:nil];
}

- (void)performAction:(NSString *)actionName withParameters:(NSDictionary *)params {
    ODActionOperation *operation = [ODActionOperation operationWithResource:self];
    operation.parameters = [params mutableCopy];
    operation.actionName = actionName;
    
    [self handleOperation:operation];
}

- (NSDictionary *)localProperties {
    return [self resourceValue];
}

@end
