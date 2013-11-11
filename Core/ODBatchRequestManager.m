//
//  ODBatchRequestManager.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODBatchRequestManager.h"

@implementation ODBatchRequestManager

- (id)init {
    self = [super init];
    if (self) {
        self.propertyFaultStrategy = ODPropertyUnfaultEntity;
        self.propertyChangeStrategy = ODPropertyChangeMerge;
    }
    return self;
}

@end
