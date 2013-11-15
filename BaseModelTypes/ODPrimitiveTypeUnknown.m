//
//  ODPrimitiveTypeUnknown.m
//  ODExplorerLib
//
//  Created by ilya on 11/15/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveTypeUnknown.h"

#import "ODJSONDateFormatter.h"

@implementation ODPrimitiveTypeUnknown

- (NSString *)primitiveName {
    return @"";
}

- (id)valueForJSONString:(NSString *)string {
    id date = [ODJSONDateFormatter dateFromString:string];
    if (date) return date;
    return string;
}

- (NSNumber *)valueForJSONNumber:(NSNumber *)obj {
    return obj;
}

@end
