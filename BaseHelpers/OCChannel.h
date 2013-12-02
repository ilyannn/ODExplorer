//
//  OCChannel.h
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCProtocols.h"

/// This macro tests |input| for being an object of a class |[Cls class]|
#define OCRequireInputType(Cls)     { if(![input isKindOfClass:[Cls class]]) { \
[self error:[NSError errorWithDomain:OCErrorDomain \
code:kOCChannelErrorInvalidInput   \
userInfo:@{@"expected": NSStringFromClass([Cls class]) } ]]; \
return; }; };

/// Use if nil is also an acceptable value for |input|
#define OCRequireInputTypeOrNil(Cls) { if (input) OCRequireInputType(Cls); }

/// This is a channel, or a pipe. It has an input and an output; input is
/// tranformed into output or an error. Both input and output can come and go in
/// chunks. Each input should give rise to one operation to be scheduled by a manager.
@interface OCChannel : NSObject <OCChannel>

@property (copy, readwrite) void (^sendBlock)(id data, BOOL error);

- (NSString *)fullDescription;

- (void)setUp;
- (void)tearDown;

/// Perform some transformation of chunk |input| into
/// (zero, one or more) outputs. For each output, use |[self send:output]|.
- (void)process:(id)input;

// Convenience methods for self.sendBlock
- (void)send:(id)data;
- (void)error:(NSError *)error;

@end
