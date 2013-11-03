//
//  ODMetadataOperation.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODMetadataOperation.h"
#import "ODMetadataModel.h"
#import "ODTypeLibrary.h"

NSString *const ODMetadataRequestString  = @"$metadata";

@implementation ODMetadataOperation

- (NSURL *)URL {
    return [[super URL] URLByAppendingPathComponent:ODMetadataRequestString];
}

- (NSError *)processResponse {
    ODMetadataModel *model = [ODMetadataModel new];
    [model updateWithData:self.response.data];
    NSLog(@"%@", [ODTypeLibrary shared].types);
    return nil;
}

@end
