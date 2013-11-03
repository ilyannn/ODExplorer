//
//  ODEntityType.m
//  OIDataNorth
//
//  Created by ilya on 10/21/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODPrimitiveType.h"
#import "ODEntity.h"
#import "ODCollection.h"
#import "ODResource+Entity.h"
#import "ODResource+Collection.h"

#import <objc/runtime.h>

@implementation ODPrimitiveType


- (instancetype)init {
    return [super initWithName:[NSString stringWithFormat:@"Edm.%@", [self primitiveName]]];
}

- (BOOL)isPrimitive {
    return YES;
}

- (NSString *)primitiveName {
    return nil;
}

- (id)valueForJSONString:(NSString *)obj {
    NSLog(@"I'm a primitive type %@, and I don't know how to handle the string '%@'", self, obj);
    return nil;
}

- (id)valueForJSONNumber:(NSString *)obj {
    NSLog(@"I'm a primitive type %@, and I don't know how to handle the number '%@'", self, obj);
    return nil;
}

- (id)valueForJSONObject:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        // "convert" to nil
        return nil;
    } else if ([obj isKindOfClass:[NSString class]]) {
        return [self valueForJSONString:obj];
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [self valueForJSONNumber:obj];
    } else {
        NSLog(@"Unknown JSON type: %@. Seriously, how does that happen?", NSStringFromClass([obj class]));
        return nil;
    }
}

- (NSString *)className {
    char x[1000];
    method_getReturnType(class_getInstanceMethod([self class], @selector(valueForJSONString:)),
                         x, sizeof(x));
    // TODO
    return @"xxx";
}

@end
