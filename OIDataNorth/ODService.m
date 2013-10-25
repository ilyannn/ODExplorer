//
//  OIDataService.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODService.h"
#import "ODCollection.h"
#import "ODBaseRequestManager.h"

@implementation ODService {
    NSURL *_serviceURL;
    NSString *_shortDescription;
}

@synthesize URL = _serviceURL;
@synthesize shortDescription = _shortDescription;

- (id)init {
    self = [super init];
    if (self) {
        self.kind = ODResourceKindCollection;
        ODBaseRequestManager *commonManager = [ODBaseRequestManager new];
        self.readManager = commonManager;
        self.changeManager = commonManager;
    }
    return self;
}

- (void)retrieveEntitySets {
    [self.readManager retrieveEntitySetsForService:self];
}

@end
