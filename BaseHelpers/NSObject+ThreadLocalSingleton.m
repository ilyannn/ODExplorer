//
//  NSObject+ThreadLocalSingleton.m
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "NSObject+ThreadLocalSingleton.h"

@implementation NSObject (ThreadLocalSingleton)

+ (instancetype)threadLocalSingleton {
    id key = self; // [NSString stringWithFormat:@"threadLocalSingleton:%@", NSStringFromClass(self)];
    NSMutableDictionary *dict = [[NSThread currentThread] threadDictionary];
    
    id shared = dict[key];
    if (shared) return shared;
    
    shared = [self new];
    if (shared) dict[key] = shared;
    
    return shared;
}

@end
