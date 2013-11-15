//
//  ODDateFormatter.m
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODDateFormatter.h"

#define MUTATES NSAssert(!self.immutable, @"This formatter is immutable");

@implementation ODDateFormatter

- (void)setDateStyle:(NSDateFormatterStyle)style { MUTATES
    [super setDateStyle:style];
}

- (void)setTimeStyle:(NSDateFormatterStyle)style { MUTATES
    [super setTimeStyle:style];
}

- (void)setTimeZone:(NSTimeZone *)tz { MUTATES
    [super setTimeZone:tz];
}

- (void)setLocale:(NSLocale *)locale { MUTATES
    [super setLocale:locale];
}

- (void)setDateFormat:(NSString *)string { MUTATES
    [super setDateFormat:string];
}

- (void)setFormatterBehavior:(NSDateFormatterBehavior)behavior { MUTATES
    [super setFormatterBehavior:behavior];
}

- (void)setCalendar:(NSCalendar *)calendar { MUTATES
    [super setCalendar:calendar];
}

- (void)setImmutable:(BOOL)immutable {
    NSAssert(immutable, @"It's not possible to turn immutable back into mutable");
    _immutable = immutable;
}

- (BOOL)testDate:(NSDate *)date {
    NSString *string = [self stringFromDate:date];
    if (!string) return NO;
    
    NSDate *date2 = [self dateFromString:string];
    if (!date2) return NO;
    
    // Can be rounded, but otherwise must match.
    return fabs([date timeIntervalSinceDate:date2]) < (NSTimeInterval)1;
}

- (NSDate *)dateFromString:(NSString *)string {
    return nil;
}

@end
