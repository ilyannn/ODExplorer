//
//  ODServiceList.m
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODServiceList.h"
#import "NorthwindService.h"

@implementation ODServiceList

- (instancetype)initFromDefaults
{
    self = [self init];
    if (self) {
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
    self.services = [NSMutableArray arrayWithObjects: exampleService, [NorthwindService new], nil];
}

- (NSString *)shortDescription {
    return @"Favorites";
}

@end
