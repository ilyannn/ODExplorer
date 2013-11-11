//
//  ODChangeManager.h
//  OIDataNorth
//
//  Created by ilya on 10/22/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//


@class ODOperation;

@protocol ODManaging <NSObject>
/// Returns YES if the operation has been handled and no further processing is necessary.
- (BOOL)handleOperation:(ODOperation *)operation;
@end

