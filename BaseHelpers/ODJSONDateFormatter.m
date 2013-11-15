//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODJSONDateFormatter.h"

@implementation ODJSONDateFormatter

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

// Method to parse /Date(...)/ strings.
+ (NSDate *)dateFromString:(NSString *)string {
    
    if (!string.length || [string characterAtIndex:0] != '/') return nil;
    
    // Answer from http://stackoverflow.com/a/6065278/115200
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    
    return nil;
}

- (NSDate *)dateFromString:(NSString *)string {
    return [self.class dateFromString:string];
}

- (NSString *)stringFromDate:(NSDate *)date {
    long long milliseconds = floor([date timeIntervalSince1970] * 1000 + (NSTimeInterval)0.5);
    return [NSString stringWithFormat:@"/Date(%lld)/", milliseconds];
}

@end
