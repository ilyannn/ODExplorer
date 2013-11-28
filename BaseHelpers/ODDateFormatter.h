//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// This is a base class for formatters that have custom implementation of -dateFromString:.
/// These formatters should be immutable and thread safe. It so happens that NSDateFormatter's
/// generic parsing method is both *slow* and *thread unsafe*. Seriously, Apple?
@interface ODDateFormatter : NSFormatter

// Override these two methods. Let's not change any state, ok?
- (NSDate *)dateFromString:(NSString *)string __attribute__((const));
- (NSString *)stringFromDate:(NSDate *)date __attribute__((const));

/// Performs a transformation to string and back, then examines result.
- (BOOL)testDate:(NSDate *)date __attribute__((const));

@end
