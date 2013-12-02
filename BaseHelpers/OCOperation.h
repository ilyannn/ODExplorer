//
//  OCOperation.h
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCProtocols.h"

@interface OCOperation : NSOperation

@property (readonly) NSArray *channels;
- (void)addInputChannel:(id<OCChannel>)ch;
- (void)addOutputChannel:(id<OCChannel>)ch;

- (NSString *)description;

@property id input;

/// Called if the last channel in the list performs a -send:
- (void)output:(id)output;

/// Number of channels that have already been torn down.
/// Before operation started equals to 0. After operation finished equals to number of channels.
@property (readonly) NSUInteger tornDownCount;

@property (readonly, nonatomic) NSError *error;

@property (atomic, readonly) BOOL isExecuting;
@property (atomic, readonly) BOOL isFinished;

- (NSError *)synchronouslyPerformFor:(id)input;

@end
