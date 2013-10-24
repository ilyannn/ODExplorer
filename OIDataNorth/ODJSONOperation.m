//
//  ODJSONOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONOperation.h"

@implementation ODJSONOperation

static AFJSONResponseSerializer *_sharedResponseSerializer;
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
    if (!_sharedResponseSerializer) {
        _sharedResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sharedResponseSerializer;
}

- (NSMutableURLRequest *)request {
    NSMutableURLRequest *request = [super request];
    [request setValue:[NSString stringWithFormat:@"application/json"] forHTTPHeaderField:@"Accept"];
    return request;
}

- (void)processResponse:(NSHTTPURLResponse *)response data:(NSData *)data {
    NSError *error;
    id responseObject = [self.responseSerializer responseObjectForResponse:response data:data error:&error];
    [self processJSONResponse: responseObject];
}

- (void)processJSONResponse:(id)responseJSON {

}

@end
