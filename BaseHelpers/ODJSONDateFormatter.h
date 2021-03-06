//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODDateFormatter.h"

/// Use instead of NSDateFormatter to parse @"/Date(.../" into date.
/// Answer from http://stackoverflow.com/a/6065278/115200
@interface ODJSONDateFormatter : ODDateFormatter

// this converter doesn't need instance data
// although you're free to call instance method if you'd like that
+ (NSDate *)dateFromString:(NSString *)string __attribute__((const));

@end
