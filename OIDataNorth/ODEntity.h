//
//  OIDataEntry.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"
#import "ODEntityType.h"

/// Public information about properties and methods of ODResource availible only for entities.
@protocol ODEntityAccessing <ODResourceAccessing>

- (id)initFromDict:(NSDictionary *)dict parentInfo:(id<ODRetrieving>)parentInfo;

+ (ODEntityType *)entityType;

// - (void)replace;
// - (ODOperation *)replaceOperation;

// - (void)merge;
// - (ODOperation *)mergeOperation;

- (id)navigationProperty:(NSString *)name propertyType:(ODEntityType *)entityType;
- (id)navigationCollection:(NSString *)name entityType:(ODEntityType *)entityType;

- (void)performAction:(NSString *)actionName;

@property (readonly, nonatomic) NSDictionary *localProperties;
@property (readonly, nonatomic) NSDictionary *remoteProperties;
@property (readonly, nonatomic) NSDictionary *navigationProperties;

@end

/// A class that works essentially as a hint to compiler.
@interface ODEntity : ODResource <ODEntityAccessing>
- (id)initFromDict:(NSDictionary *)dict parentInfo:(id<ODRetrieving>)parentInfo;

@end