//
//  ODFavorites.m
//  OIDataNorth
//
//  Created by ilya on 11/6/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODFavorites.h"

#import "ODResource_Internal.h"
#import "ODRetrieving_Objects.h"
#import "ODCollection.h"

#import "NorthwindService.h"

@implementation ODFavorites

+ (instancetype)sharedFavorites {
    static ODFavorites *shared;
    if (!shared) {
        shared = [[self alloc] initFromDefaults];
    }
    return shared;
}

- (instancetype)initFromDefaults {
    self = [self init];
    if (self) {
        self.retrievalInfo = [ODRetrieveBase new];
        self.kind = ODResourceKindCollection;
        [self loadFromDefaults];
    }
    return self;
}

- (void)saveToDefaults {
    
}

- (void)loadFromDefaults {
    ODRetrieveByURL *info = [ODRetrieveByURL new];
    info.URL = [NSURL URLWithString:@"http://services.odata.org/V3/OData/OData.svc/"];
    info.shortDescription = @"OData Example";
    //    info.parent = self.retrievalInfo;
    
    
    ODCollection *exampleService = [ODCollection resourceWithInfo:info];
    
    self.childrenArray = [NSMutableArray arrayWithObjects:exampleService,
                          
                          [NorthwindService unique],
                          
                          [ODCollection resourceWithDict: @{
                                                            @"uri":  @"http://packages.nuget.org/v1/FeedService.svc/Packages",
                                                            @"name": @"NuGet Packages"
                                                            }],
                          
                          [ODCollection resourceWithDict:   @{
                                                              @"uri":  @"http://tv.telerik.com/services/odata.svc/",
                                                              @"name": @"Telerik"
                                                              }],
                          
                          [ODCollection resourceWithDict: @{  @"uri":  @"http://odata4j-sample.appspot.com/datastore.svc/",
                                                              @"name": @"OData4j Sample"
                                                              }],
                          
                          nil];
    
}

- (NSString *)shortDescription {
    return @"Favorites";
}


@end
