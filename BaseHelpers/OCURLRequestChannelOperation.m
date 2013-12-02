//
//  OCHTTPRequestChannelOperation.m
//  ODExplorerLib
//
//  Created by ilya on 12/1/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCURLRequestChannelOperation.h"

@implementation OCURLRequestChannelOperation

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [super connection:connection didReceiveData:data];
    self.sendBlock(data, NO);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [super connection:connection didReceiveResponse:response];
    self.sendBlock(response, NO);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [super connection:connection didFailWithError:error];
    self.sendBlock(error, YES);
}

@end
