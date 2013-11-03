//
//  ODType.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODType.h"
#import "ODType+Primitive.h"

@implementation ODType

NSMutableDictionary *_types;

+ (void)initialize {
    _types = [NSMutableDictionary new];
    for (ODPrimitiveType *type in [self listPrimitiveTypes])
        [self registerPrimitiveType:type];
}

+ (void)registerPrimitiveType:(ODType *)type {
    _types[type.name] = type;
    _types[[@"Edm." stringByAppendingString:type.name]] = type;
}

+ (ODType *)uniqueTypeFor:(NSString *)typeName {
    if (!typeName) return nil;
    
    ODType *result = _types[typeName];
    if (!result) {
        result = [[self alloc] initWithName:typeName];
        _types[typeName] = result;
    }
    
    return [result isKindOfClass:[self class]] ? result : nil;
}

// Can't create without a name;
- (id)init {
    return nil;
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (NSString *)description {
    return self.name;
}

- (BOOL)isPrimitive {
    return NO;
}

- (id)valueForJSONObject:(id)obj {
    return obj;
}

@end
