//
//  ODContext.h
//  ODExplorerLib
//
//  Created by ilya on 11/14/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODManaging.h"

@interface ODManager : NSObject <ODManaging>
+ (instancetype)sharedManager;
+ (void)setSharedManager:(ODManager *)context;

@property id<ODManaging> parentManager;
- (BOOL)willHandle:(ODOperation *)operation;
- (void)didHandle:(ODOperation *)operation;

@end
