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

- (void)saveToDefaults {
}

- (void)loadFromDefaults {
    ODRetrievalByURL *info = [ODRetrievalByURL new];
    info.URL = [NSURL URLWithString:@"http://services.odata.org/V3/OData/OData.svc/"];
    info.shortDescription = @"OData Example";
    info.parent = self.retrievalInfo;
    
    ODService *exampleService = [ODService resourceWithInfo:info];
    
    self.childResources = [NSMutableArray arrayWithObjects:exampleService,
                           [NorthwindService unique],
                           [ODService resourceWithDict: @{
                                                            @"uri":  @"http://packages.nuget.org/v1/FeedService.svc/",
                                                            @"name": @"NuGet Packages"
                                                            }],
                           [ODService resourceWithDict: @{  @"uri":  @"http://tv.telerik.com/services/odata.svc/",
                                                            @"name": @"Telerik"
                                                          }],
                           [ODService resourceWithDict: @{  @"uri":  @"http://odata4j-sample.appspot.com/datastore.svc/",
                                                            @"name": @"OData4j Sample"
                                                            }],
                           
                           
                           nil];
}

- (NSString *)shortDescription {
    return @"Favorites";
}

@end
