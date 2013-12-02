//
//  OCProtocols.h
//  ODExplorerLib
//
//  Created by ilya on 12/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//
//
//  Channel can be described by the following co-procedure:
//  try {
//     perform_setup_operation
//     while (input = receive_input) {
//        ... // do something
//        send: output
//        ...
//        error: error
//        ...
//     }
//  finally {
//     perform_teardown_operation;
//  }
//
// Objective-C has no notion of co-procedures, so every chunk of code is in NSOperation.
// Channel can request that all of its operations are performed on main queue.

extern NSString * const OCErrorDomain;

/// Different places where an observable error can occur.
typedef NS_ENUM(NSInteger, OCErrorType) {
    kOCChannelErrorInvalidInput         = 1,
    kOCChannelErrorUnexpectedOutput     = 2,
    kOCChannelErrorInternalException    = 3,
    kOCOperationWasCanceled             = 4,
};

/// This encapsulates an idea of a channel: it should have metadata, know how to do stuff,
/// nd there whould be a way to provide it with a callback for results. Note that a single
/// channel instance can only perform work in a specific position in a specific manager at a time.
/// It's not required to be thread-safe; managers won't call two methods at the same time.
@protocol OCChannel <NSObject>

/// Used in operation's description (input of operation = input of first channel).
- (NSString *)inputDescription;

/// Used in operation's description (output of operation = output of last channel).
- (NSString *)outputDescription;

/// If YES, operations are scheduled on main thread.
- (BOOL)requiresMainThread;

/// Scheduled before the first chunk. Cannot be nil.
- (NSOperation *)setUpOperation;

/// Scheduled after the last chunk. Cannot be nil.
- (NSOperation *)tearDownOperation;

/// Operation for each chunk. Cannot be nil.
- (NSOperation *)processOperationFor:(id)input;

/// This is a manager's callback.
- (void)setSendBlock:(void(^)(id data, BOOL error))sendBlock;

@end
