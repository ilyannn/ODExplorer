//
//  OCHTTPRequestChannel.m
//  ODExplorerLib
//
//  Created by ilya on 12/1/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCURLRequestChannel.h"
#import "OCURLRequestChannelOperation.h"
#import "OCDummyOutputStream.h"

@implementation OCURLRequestChannel

- (NSOperation *)processOperationFor:(id)input {
    OCURLRequestChannelOperation *op = [[OCURLRequestChannelOperation alloc] initWithRequest:input];
    op.outputStream = [OCDummyOutputStream new];
    op.sendBlock = self.sendBlock;
    return op;
}

- (NSString *)inputDescription {
    return @"NSURLRequest *";
}

- (NSString *)outputDescription {
    return @"NSURLResponse * or NSData *";
}

@end
