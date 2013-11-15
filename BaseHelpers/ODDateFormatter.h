//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// This is a base class for formatters that have custom implementation of -dateFromString:.
/// These formatters should be thread safe, unlike NSDateFormatter. I mean those are both *slow* and
/// *thread unsafe*. Seriously, Apple?.
@interface ODDateFormatter : NSFormatter

// Override these two methods. 
- (NSDate *)dateFromString:(NSString *)string;
- (NSString *)stringFromDate:(NSDate *)date;

/// Performs a transformation to string and back, then examines result.
- (BOOL)testDate:(NSDate *)date;

@end
