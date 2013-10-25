//
//  OIDataService.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource.h"

@class ODCollection;

// Service is a parent OData resource.

@interface ODService : ODResource

@property (nonatomic) NSURL *URL;
@property (nonatomic) NSString *shortDescription;

@property NSDictionary *entitySets;
- (void)retrieveEntitySets;

@end
