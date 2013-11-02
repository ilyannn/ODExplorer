//
//  ODEdmString.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEdmString.h"

@implementation ODEdmString

- (instancetype) init {
    return [super initWithName:@"String"];
}

- (id)valueForJSONString:(NSString *)obj {
    return obj;
}

- (id)valueForJSONNumber:(NSNumber *)obj {
    return [NSString stringWithFormat:@"%@", obj];
}

@end
