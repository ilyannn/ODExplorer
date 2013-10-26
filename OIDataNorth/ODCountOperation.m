//
//  ODCountOperation.m
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODCountOperation.h"
#import "ODOperationResponse.h"

NSString *const ODQueryCountString  = @"$count";

@implementation ODCountOperation

- (NSURL *)URL {
    return [[super URL] URLByAppendingPathComponent:ODQueryCountString];
}

- (void)processResponse:(ODOperationResponse *)response {
    _responseCount = [[[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding] integerValue];
}

@end
