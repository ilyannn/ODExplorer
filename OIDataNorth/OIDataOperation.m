//
//  OIDataQuery.m
//  OIDataNorth
//
//  Created by ilya on 10/18/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OIDataOperation.h"


@implementation OIDataOperation


- (NSURLRequest *)URLRequest {
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    request.HTTPMethod = self.method;
    request.cachePolicy = NSURLRequestReloadRevalidatingCacheData;
    return [request copy];
}

- (NSURL *)URL {
    return [NSURL URLWithString:(NSString *) relativeToURL:self.service.serviceURL]
}

// Redefine this in subclasses
- (NSString *)method {
    abort();
}

@end
