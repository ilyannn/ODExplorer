//
//  OIDataService.h
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataResource.h"

@class OIDataCollection;

// Service is a parent OData resource.

@interface OIDataService : OIDataResource

@property (readonly, nonatomic) NSURL *hostURL;
@property (readonly, nonatomic) NSString *servicePath;

- (OIDataCollection *)getCollection:(NSString *)collectionName;

@end
