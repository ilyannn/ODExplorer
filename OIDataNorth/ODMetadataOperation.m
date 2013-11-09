//
//  ODMetadataOperation.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODMetadataOperation.h"
#import "ODataModel.h"
#import "ODTypeLibrary.h"

NSString *const ODMetadataRequestString  = @"$metadata";

@implementation ODMetadataOperation

- (NSURL *)URL {
    return [[super URL] URLByAppendingPathComponent:ODMetadataRequestString];
}

- (NSError *)processResponse {
    ODataModel *model = [ODataModel new];
    [model updateWithData:self.response.data];
    _responseModel = model;
    return nil;
}

@end
