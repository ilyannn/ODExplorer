//
//  ODDateFormatter.m
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODDateFormatter.h"

@implementation ODDateFormatter

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

- (NSString *)stringFromDate:(NSDate *)date {
    return nil;
}

- (NSString *)stringForObjectValue:(id)obj {
    return [obj isKindOfClass:[NSDate class]] ? [self stringFromDate:obj] : nil;
}

- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error {
    NSDate *date = [self dateFromString:string];
    *anObject = date;

    if (!date && error) {
        *error = NSLocalizedString(@"Couldn’t convert string to date.", @"Error when converting");
    }
    
    return !!date;
}

@end
