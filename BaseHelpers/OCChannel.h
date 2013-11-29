//
//  OCChannel.h
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

/// This is a channel, or a pipe. It has an input and an output; input is
/// tranformed into output or an error. Both input and output can come and go in
/// chunks. Each input should give rise to one operation which is scheduled by a manager.
@interface OCChannel : NSObject

/// This is a manager's callback. Note that a single instance cannot be shared
/// between two managers at the same time.
@property (copy, readwrite) void (^sendBlock)(id data, BOOL error);

+ (Class)requiredInputClass;
+ (Class)requiredOutputClass;

- (NSString *)description;

/// If YES, process: is called on main thread.
- (BOOL)requiresMainThread;
- (BOOL)validateInput:(id)input;
- (BOOL)validateOutput:(id)output;

- (void)send:(id)data;
- (void)error:(NSError *)error;

/// Called before the first chunk.
- (void)setup;

/// Called after the last chunk.
- (void)teardown;

/// Perform some transformation of chunk |input| into
/// (zero, one or more) outputs. For each output, use |[self send:output]|.
- (void)process:(id)input;

@end
