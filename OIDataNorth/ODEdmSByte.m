//
//  ODEdmSByte.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEdmSByte.h"

@implementation ODEdmSByte

- (instancetype)init {
    return [super initWithName:@"SByte"];
}

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

@end
