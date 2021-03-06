//
//  ODSimpleRequestManager.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManager.h"

typedef NS_ENUM (NSInteger, ODPropertyChangeStrategy) {
    ODPropertyChangeIgnore,
    ODPropertyChangeReplace,
    ODPropertyChangeMerge,
    ODPropertyChangeUpdate
};

typedef NS_ENUM (NSInteger, ODPropertyFaultStrategy) {
    ODPropertyFaultReturn,
    ODPropertyFaultExcept,
    ODPropertyUnfaultEntity,
    ODPropertyUnfaultProperty
};

@interface ODBaseRequestManager : ODManager <ODManaging>

// New manager gets separate operations queue by default
@property NSOperationQueue *operationQueue;
@property ODPropertyFaultStrategy propertyFaultStrategy;
@property ODPropertyChangeStrategy propertyChangeStrategy;

@end
