//
//  OCHTTPRequestChannel.m
//  ODExplorerLib
//
//  Created by ilya on 12/1/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCHTTPRequestChannel.h"
#import "OCHTTPRequestChannelOperation.h"
#import "OCDummyOutputStream.h"

@implementation OCHTTPRequestChannel

- (NSOperation *)processOperationFor:(id)input {
    OCHTTPRequestChannelOperation *op = [[OCHTTPRequestChannelOperation alloc] initWithRequest:input];
    op.outputStream = [OCDummyOutputStream new];
    op.sendBlock = ^(id data) { [self send:data]; };
    op.errorBlock = ^(NSError *error) { [self error:error]; };
    return op;
}

- (NSString *)inputDescription {
    return @"NSURLRequest instance";
}

- (NSString *)outputDescription {
    return @"NSURLResponse and NSData instances";
}

@end
