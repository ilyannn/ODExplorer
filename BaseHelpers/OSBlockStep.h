//
//  OSCustomStep.h
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OSOperationStep.h"

typedef NSError * (^OSBlockType)(id op);

@interface OSBlockStep : OSOperationStep

+ (instancetype)step:(NSString *)description withBlock:(OSBlockType)block;
+ (instancetype)mainThreadStep:(NSString *)description withBlock:(OSBlockType)block;
- (instancetype)initWithBlock:(OSBlockType)block description:(NSString *)description mainThread:(BOOL)mainThread;
@end
