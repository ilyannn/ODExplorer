//
//  NSObject+ThreadLocalSingleton.h
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ThreadLocalSingleton)

+ (instancetype)threadLocalSingleton;

@end
