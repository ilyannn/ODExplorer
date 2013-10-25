//
//  ODChangeManager.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//


@class ODEntity, ODService, ODCollection;

@protocol ODChangeManaging <NSObject>
- (void)performAction:(NSString *)actionName for:(ODEntity *)entity withParameters:(NSDictionary *)params;
@end

@protocol ODFaultManaging <NSObject>
- (void)retrieveCount:(ODCollection *)collection;
- (void)retrieveEntity:(ODEntity *)entity;
- (void)retrieveProperty:(NSString *)propertyName ofEntity:(ODEntity *)entity;
- (void)retrieveEntitySetsForService:(ODService *)service;
@end
