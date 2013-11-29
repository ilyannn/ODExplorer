//
//  OCOperation.h
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCChannel.h"

@interface OCOperation : NSOperation

@property (readonly) NSArray *channels;
- (void)addFirstChannel:(OCChannel *)ch;
- (void)addLastChannel:(OCChannel *)ch;


@property id input;

/// Number of bhannels that have already been torn down.
/// Before operation started equals to 0. After operation finished equals to number of channels.
@property (readonly) NSUInteger tearedDownCount;

@property (readonly) NSError *error;

@property (atomic, readonly) BOOL isExecuting;
@property (atomic, readonly) BOOL isFinished;

@end
