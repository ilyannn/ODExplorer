//
//  OIDataEntry.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"
#import "ODType.h"

/// Public information about properties and methods of ODResource availible only for entities.
@protocol ODEntityAccessing <ODResourceAccessing>

- (NSError *)parseFromJSONDictionary:(NSDictionary *)dict;

// - (void)replace;
// - (ODOperation *)replaceOperation;

// - (void)merge;
// - (ODOperation *)mergeOperation;

- (id)navigationProperty:(NSString *)name propertyType:(ODType *)entityType;
- (id)navigationCollection:(NSString *)name entityType:(ODType *)entityType;

- (void)performAction:(NSString *)actionName;

@property (readonly, nonatomic) NSDictionary *localProperties;
// @property (readonly, nonatomic) NSDictionary *remoteProperties;
// @property (readonly, nonatomic) NSDictionary *navigationProperties;

@end

@class ODCustomEntityType;

/// A class that works essentially as a hint to compiler.
@interface ODEntity : ODResource <ODEntityAccessing>
+ (ODCustomEntityType *)customEntityType;
@end