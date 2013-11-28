//
//  OSCustomStep.h
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OSOperationStep.h"

@interface OSBlockStep : OSOperationStep

+ (instancetype)step:(NSString *)description withBlock:(NSError *(^)(id))block;
+ (instancetype)mainThreadStep:(NSString *)description withBlock:(NSError *(^)(id))block;
- (instancetype)initWithBlock:(NSError *(^)(id))block description:(NSString *)description mainThread:(BOOL)mainThread;
@end
