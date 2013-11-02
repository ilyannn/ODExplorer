//
//  ODEdmGuid.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEdmGuid.h"

@implementation ODEdmGuid

- (instancetype) init {
    return [super initWithName:@"Guid"];
}

- (NSUUID *)valueForJSONString:(NSString *)obj {
    return [[NSUUID alloc] initWithUUIDString:obj];
}

@end
