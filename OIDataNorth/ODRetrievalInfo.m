//
//  ODRetrievalInfo.m
//  OIDataNorth
//
//  Created by ilya on 10/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODRetrievalInfo.h"
#import "ODManagingProtocols.h"
#import "ODBaseRequestManager.h"

@implementation ODRetrievalInfo

- (id)init
{
    self = [super init];
    if (self) {
        ODBaseRequestManager *commonManager = [ODBaseRequestManager new];
        self.readManager = commonManager;
        self.changeManager = commonManager;
    }
    return self;
}

- (id)getFromHierarhy:(SEL)selector {
    for (ODRetrievalInfo *info = self;info;info = info.parent) {
        id value = [info performSelector:selector];
        if (value) return value;
    }
    return nil;
}

@end
