//
//  ODPrimitiveTypeDateTime.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeDateTime.h"
#import "ODJSONDateReader.h"

@implementation ODPrimitiveTypeDateTime

- (NSString *)primitiveName {
    return @"DateTime";
}

- (id)dateTimeFormatterV2 {
    static id shared ;
    if (!shared) {
        shared = [ODJSONDateReader new];
    }
    return shared;
}

- (id)dateTimeFormatterV3 {
    static NSDateFormatter *shared ;
    if (!shared) {
        shared = [NSDateFormatter new];
        shared.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        shared.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    }
    return shared;
}

- (NSDate *)valueForJSONString:(NSString *)obj {
    NSDate *date;
    if ((date = [self.dateTimeFormatterV2 dateFromString:obj])) return date;
    if ((date = [self.dateTimeFormatterV3 dateFromString:obj])) return date;
    return nil;
}

- (NSDate *)valueForJSONNumber:(NSNumber *)obj {
    return nil;
}

@end
