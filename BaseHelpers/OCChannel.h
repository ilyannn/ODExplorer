//
//  OCChannel.h
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

extern NSString * const OCChannelErrorDomain;

typedef NS_ENUM(NSInteger, OCChannelErrorType) {
    kOCChannelErrorInvalidInput = 1,
    kOCChannelErrorUnexpectedOutput = 2,
    kOCChannelErrorInternalException = 3,
    kOCOperationWasCanceled = 4,
};

/// This macro tests |input| for being an object of a class |[Cls class]|
#define OCRequireInputType(Cls)     { if(![input isKindOfClass:[Cls class]]) { \
[self error:[NSError errorWithDomain:OCChannelErrorDomain \
code:kOCChannelErrorInvalidInput   \
userInfo:@{@"expected": NSStringFromClass([Cls class]) } \
]]; \
return; \
}; };

/// Use if nil is also an acceptable value for |input|
#define OCRequireInputTypeOrNil(Cls) { if (input) OCRequireInputType(Cls); }


/// This is a channel, or a pipe. It has an input and an output; input is
/// tranformed into output or an error. Both input and output can come and go in
/// chunks. Each input should give rise to one operation to be scheduled by a manager.
@interface OCChannel : NSObject

/// This is a manager's callback. Note that a single instance cannot be shared
/// between two managers at the same time.
@property (copy, readwrite) void (^sendBlock)(id data, BOOL error);

- (NSString *)description;
- (NSString *)inputDescription;
- (NSString *)outputDescription;
- (NSString *)fullDescription;

/// If YES, operation returned by processOperationFor: is scheduled on main thread.
- (BOOL)requiresMainThread;

- (void)send:(id)data;
- (void)error:(NSError *)error;

/// Scheduled before the first chunk. Cannot be nil.
- (NSOperation *)setUpOperation;

/// Scheduled after the last chunk. Cannot be nil.
- (NSOperation *)tearDownOperation;

/// Operation for each chunk. Cannot be nil.
- (NSOperation *)processOperationFor:(id)input;

- (void)setUp;
- (void)tearDown;

/// Perform some transformation of chunk |input| into
/// (zero, one or more) outputs. For each output, use |[self send:output]|.
- (void)process:(id)input;

@end
