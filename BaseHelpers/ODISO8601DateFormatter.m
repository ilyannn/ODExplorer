//
//  ODISO8601DateReader.m
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODISO8601DateFormatter.h"

#import "CBLParseDate.h"

@implementation ODISO8601DateFormatter

- (instancetype)init {
    if (self = [super init]) {
        self.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        self.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
        self.immutable = YES;
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

@end
