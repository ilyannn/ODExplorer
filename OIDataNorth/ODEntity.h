//
//  OIDataEntry.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"
#import "ODEntityType.h"
#import "ODEntitySet.h"

@interface ODEntity : ODResource
- (instancetype)initFromDict:(NSDictionary *)dict parentInfo:(id<ODRetrieving>)parentInfo;
- (void)updateFromDict:(NSDictionary *)dict;

+ (ODEntityType *)entityType;
- (ODEntityType *)entityType;

@property (readonly, nonatomic) NSDictionary *localProperties;
@property (readonly, nonatomic) NSDictionary *remoteProperties;
@property (readonly, nonatomic) NSMutableDictionary *navigationProperties;

- (id)navigationProperty:(NSString *)name propertyType:(ODEntityType *)entityType;
- (id)navigationCollection:(NSString *)name entityType:(ODEntityType *)entityType;

- (void)performAction:(NSString *)actionName;

@end
