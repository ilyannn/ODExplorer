//
//  Created by ilya on 10/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// Use instead of NSDateFormatter to parse @"/Date(.../" into date.
/// Answer from http://stackoverflow.com/a/6065278/115200
@interface JSONDateReader : NSObject
- (NSDate *)dateFromString:(NSString *)string;
@end
