//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODDateFormatter.h"

/// Use instead of NSDateFormatter to parse @"/Date(.../" into date.
/// Answer from http://stackoverflow.com/a/6065278/115200
@interface ODJSONDateFormatter : ODDateFormatter

// this converter doesn't need instance data
+ (NSDate *)dateFromString:(NSString *)string;

@end
