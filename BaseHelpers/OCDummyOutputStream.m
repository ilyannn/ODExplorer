//
//  OCDummyOutputStream.m
//  ODExplorerLib
//
//  Created by ilya on 12/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCDummyOutputStream.h"

@implementation OCDummyOutputStream

- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)length {
    return length;
}

- (BOOL)hasSpaceAvailable {
    return YES;
}

@end
