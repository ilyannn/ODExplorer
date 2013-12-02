//
//  OCRequestSaverChannel.m
//  ODExplorerLib
//
//  Created by ilya on 12/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCHTTPResponseAnalyzerChannel.h"

@implementation OCHTTPResponseAnalyzerChannel {
    NSMutableArray *_responses;
}

- (NSArray *)responses {
    return [_responses copy];
}

- (void)setUp {
    _responses = [NSMutableArray new];
}

- (NSString *)inputDescription {
    return @"NSURLResponse and NSData instances";
}

- (NSString *)outputDescription {
    return @"NSData *";
}

- (void)process:(id)input {
    if ([input isKindOfClass:[NSURLResponse class]]) {
        [_responses addObject:input];
        [self analyzeResponse:input];
    } else {
        OCRequireInputType(NSData);
        [self send: input];
    }
}

- (void)analyzeResponse:(NSURLResponse *)response {
    // do nothing
}

@end
