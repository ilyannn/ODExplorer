//
//  ODEntityProtocol.h
//  OIDataNorth
//
//  Created by ilya on 11/8/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource_Protocol.h"

/// Public information about properties and methods of ODResource availible only for entities.
@protocol ODEntity <ODResource>

- (NSError *)parseFromJSONDictionary:(NSDictionary *)dict;

// - (void)replace;
// - (ODOperation *)replaceOperation;

// - (void)merge;
// - (ODOperation *)mergeOperation;

// - (id)navigationProperty:(NSString *)name propertyType:(ODType *)entityType;
- (id)navigationCollection:(NSString *)name entityType:(ODType *)entityType;

// - (void)performAction:(NSString *)actionName;

@property (readonly, nonatomic) NSDictionary *localProperties;

@end

