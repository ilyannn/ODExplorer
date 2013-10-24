//
//  ODCountOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCountOperation.h"

NSString * const ODQueryCountString  = @"$count";

@implementation ODCountOperation

- (NSURL *)URL {
    return [[super URL] URLByAppendingPathComponent:ODQueryCountString];
}

- (void)processResponse:(NSURLResponse *)response data:(NSData *)data {
    _responseCount = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] integerValue];
}

@end
