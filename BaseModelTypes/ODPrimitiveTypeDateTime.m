//
//  ODPrimitiveTypeDateTime.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeDateTime.h"

#import "ODJSONDateFormatter.h"
#import "ODISO8601DateFormatter.h"

#define RETURN_SINGLETON(block) { static dispatch_once_t token; static id singleton; \
dispatch_once(&token, ^{block}); return singleton; }

@implementation ODPrimitiveTypeDateTime

- (NSString *)primitiveName {
    return @"DateTime";
}

// NSDateFormatter is not thread-safe, but our formatters should be.

- (ODDateFormatter *)dateTimeFormatterV2 RETURN_SINGLETON({
    singleton = [ODJSONDateFormatter new];
})


- (ODDateFormatter *)dateTimeFormatterV3 RETURN_SINGLETON({
    singleton = [ODISO8601DateFormatter new];
})

- (NSDate *)valueForJSONString:(NSString *)string {
    if (![string length]) return nil;

    // We avoid creating any date formatters here, but rather call corresponding
    // functions directly. This sidesteps 'NSDateFormatter not thread-safe' problem.
    if ([string characterAtIndex:0] == '/') {
        return [ODJSONDateFormatter dateFromString:string];
    } else {
        return [ODISO8601DateFormatter dateFromString:string];
    }
}

- (NSDate *)valueForJSONNumber:(NSNumber *)obj {
    return nil;
}

@end
