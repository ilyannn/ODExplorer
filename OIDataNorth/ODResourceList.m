//
//  ODServiceList.m
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceList.h"
#import "NorthwindService.h"

@implementation ODResourceList

- (instancetype)initFromDefaults {
    self = [self init];
    if (self) {
        self.retrievalInfo = [ODRetrievalInfo new];
        self.kind = ODResourceKindCollection;
        [self loadFromDefaults];
    }
    return self;
}

- (NSURL *)URL {
    return nil;
}

- (void)saveToDefaults {
}

- (void)loadFromDefaults {
    ODService *exampleService = [ODService new];
    exampleService.URL = [NSURL URLWithString:@"http://services.odata.org/V3/OData/OData.svc/"];
    exampleService.shortDescription = @"OData Example";
    exampleService.retrievalInfo = self.retrievalInfo;
    self.childResources = [NSMutableArray arrayWithObjects:exampleService, [NorthwindService new], nil];
}

- (NSString *)shortDescription {
    return @"Favorites";
}

@end