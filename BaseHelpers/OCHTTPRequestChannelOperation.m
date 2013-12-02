//
//  OCHTTPRequestChannelOperation.m
//  ODExplorerLib
//
//  Created by ilya on 12/1/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCHTTPRequestChannelOperation.h"

@implementation OCHTTPRequestChannelOperation

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [super connection:connection didReceiveData:data];
    if (self.sendBlock) {
        self.sendBlock(data);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [super connection:connection didReceiveResponse:response];
    if (self.sendBlock) {
        self.sendBlock(response);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [super connection:connection didFailWithError:error];
    if (self.errorBlock) {
        self.errorBlock(error);
    }
}

@end
