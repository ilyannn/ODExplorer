//
//  ODISO8601DateReader.m
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODISO8601DateFormatter.h"

#import "CBLParseDate.h"

@implementation ODISO8601DateFormatter {
    NSDateFormatter *_outDateFormatter;
}

- (instancetype)init {
    if (self = [super init]) {
        _outDateFormatter = [NSDateFormatter new];
        _outDateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        _outDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    }
    return self;
}

+ (NSDate *)dateFromString:(NSString *)string {
    double date = CBLParseISO8601Date([string cStringUsingEncoding:NSUTF8StringEncoding]);
    return date == NAN ? nil : [NSDate dateWithTimeIntervalSince1970:date];
}

- (NSDate *)dateFromString:(NSString *)string {
    return [[self class] dateFromString:string];
}

- (NSString *)stringFromDate:(NSDate *)date {
    // I hope at least this is thread-safe.
    return [_outDateFormatter stringFromDate:date];
}

@end
