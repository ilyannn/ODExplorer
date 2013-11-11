//
//  ODNotifyingManager.h
//  OIDataNorth
//
//  Created by ilya on 10/27/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManaging.h"

@class ODNotifyingManager;

@protocol ODNotifyingManagerDelegate <NSObject>
- (void)manager:(ODNotifyingManager *)manager willStart:(ODOperation *)operation;
- (void)manager:(ODNotifyingManager *)manager didFinish:(ODOperation *)operation;
@end

/// This manager tracks operations that pass through it.
/// All of its property changes, notifications, and delegate calls work on the main thread.

@interface ODNotifyingManager : NSObject <ODManaging>
- (instancetype)initWithDelegate:(id<ODNotifyingManagerDelegate>)delegate;

@property NSHashTable *currentOperations;

/// This property can be used for KVO notifications.
@property (readonly) BOOL hasOperations;

/// Or you can use this delegate
@property (weak) id<ODNotifyingManagerDelegate> delegate;

@end
