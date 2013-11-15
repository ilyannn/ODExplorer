//
//  ODDateFormatter.h
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// This is a base class for formatters that have custom implementation of -dateFromString:.
/// It's a good idea to set -immutable = YES after initialization.
/// An implementation without side effects then should make this formatter thread safe, yay!
@interface ODDateFormatter : NSDateFormatter

/// Once this property is set (in subclasses' -init), setters will fail.
@property (getter = isImmutable, nonatomic) BOOL immutable;

/// Performs a transformation to string and back, then examines result.
- (BOOL)testDate:(NSDate *)date;

@end
