//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//


#import "ODDateFormatter.h"

/// Use instead of NSDateFormatter to parse @"2013-09-07T23:45:00Z" into date.
/// Using http://github.com/couchbase/couchbase-lite-ios/blob/master/Source/CBLParseDate.c
@interface ODISO8601DateFormatter : ODDateFormatter

// this converter doesn't need instance data
// although you're free to call instance method if you'd like that
+ (NSDate *)dateFromString:(NSString *)string __attribute__((const));

@end
