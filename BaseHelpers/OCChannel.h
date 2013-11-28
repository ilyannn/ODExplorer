//
//  OCChannel.h
//  ODExplorerLib
//
//  Created by ilya on 11/28/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCChannel;

@interface OCChannel : NSObject
@property (copy, readwrite) void (^sendBlock)(id data, BOOL error);

+ (Class)requiredInputClass;
+ (Class)requiredOutputClass;

- (NSString *)description;
- (BOOL)requiresMainThread;
- (BOOL)validateInput:(id)input;
- (BOOL)validateOutput:(id)output;
- (NSOperation *)operationWith:(id)input;

- (void)send:(id)data;
- (void)error:(NSError *)error;

- (void)setup;
- (void)process:(id)input;

@end
