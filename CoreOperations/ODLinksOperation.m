//
//  ODLinksOperation.m
//  OIDataNorth
//
//  Created by ilya on 11/4/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODLinksOperation.h"
#import "ODOperationError+Parsing.h"

NSString *const ODGetLinksString  = @"$links";

@implementation ODLinksOperation

- (NSURL *)URL {
    return [[super URL] URLByAppendingPathComponent:ODGetLinksString];
}

- (NSError *)processJSONResponseVerbose {
    ODAssertODataClass(self.responseJSON, NSDictionary);
    NSNumber *count = self.responseJSON[@"odata.count"];
    
    ODAssertODataClass(count, NSNumber);
    id url = self.responseJSON[@"url"];
    
    if ([url isKindOfClass:[NSString class]]) {
        _responseCount = 1;
        return nil;
    }
    
    return nil;
}

@end
