//
//  ODServiceList.m
//  OIDataNorth
//
//  Created by ilya on 10/25/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResourceList.h"
#import "ODResource_Internal.h"

#import "ODRetrieving_Objects.h"

#import "NorthwindService.h"
#import "ODOperation.h"

@implementation ODResourceList

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
/*                          [ODCollection resourceWithDict:@{@"uri": @"https://api.datamarket.azure.com/Data.ashx/UnitedNations/MDG/", @"name": @"UN Data Example"}],
 */

                           nil];

                          }

- (NSString *)shortDescription {
    return @"Favorites";
}

- (void)addResourceToList:(ODResource *)resource {
    ODOperation *operation = [ODOperation new];
    [operation addOperationStep:^NSError *(id op) {
        [self.childrenArray addObject:[ODResource resourceByURLCopy:resource in:self.retrievalInfo]];
        return nil;
    }];
    [self handleOperation:operation];
}

- (void)removeResourceFromList:(ODResource *)resource {
    ODOperation *operation = [ODOperation new];
    [operation addOperationStep:^NSError *(id op) {
        [self.childrenArray removeObject:resource];
        return nil;
    }];
    [self handleOperation:operation];
}

- (void)retrieve {
    
}

- (void)retrieveMetadata {
    for (ODResource<ODCollectionAccessing> *resource in self.childrenArray) {
        [resource retrieveMetadata];
    }
}

@end
