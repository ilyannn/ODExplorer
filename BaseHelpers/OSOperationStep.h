//
//  OSOperationStep.h
//  ODExplorerLib
//
//  Created by ilya on 11/16/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@interface OSOperationStep : NSObject

+ (OSOperationStep *)step:(NSString *)description withBlock:(NSError *(^)(id))block;
+ (OSOperationStep *)mainThreadStep:(NSString *)description withBlock:(NSError *(^)(id))block;

- (NSString *)description;
- (BOOL)requiresMainThread;

- (NSError *)perform:(id)op;

@end
