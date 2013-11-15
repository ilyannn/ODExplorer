//
//  ODEntityType.m
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODStructuredType.h"
#import "ODStructuredType_Mutable.h"
#import "ODMutableStructuredType.h"

@implementation ODStructuredType {
    BOOL _mutable;
    NSDictionary *_properties;
    NSArray *_keyProperties;
    NSString *_name;
}

- (instancetype)initWithName:(NSString *)name properties:(NSDictionary *)properties keys:(NSArray *)keys {
    if (self = [super init]) {
        _name = [name copy];
        _properties = [properties copy];
        _keyProperties = [keys copy];
    }
    return self;
}

- (BOOL)isComplex {
    return !self.hasKeys;
}

- (BOOL)isEntity {
    return self.hasKeys;
}

- (BOOL)hasKeys {
    return !![self.keyProperties count];
}

- (NSString *)name {
    return _name;
}

- (instancetype)initMutableWithName:(NSString *)name {
    if (self = [super init]) {
        _mutable = YES;
        _name = name;
        _properties = [NSMutableDictionary new];
        _keyProperties = [NSMutableArray new];
    }
    return self;
}

- (ODStructuredType *)copyWithZone:(NSZone *)zone {
    return [[ODStructuredType alloc] initWithName:self.name properties:self.properties keys:self.keyProperties];
}

- (ODMutableStructuredType *)mutableCopyWithZone:(NSZone *)zone {
    ODMutableStructuredType *copy = [[ODMutableStructuredType alloc] initWithName:self.name];
    [copy.properties addEntriesFromDictionary:self.properties];
    [copy.keyProperties addObjectsFromArray:self.keyProperties];
    return copy;
}

- (void)setMutable:(BOOL)mutable {
    if (mutable != _mutable) {
        if (_mutable) {
            // Cannot be made mutable from immutable. 
//            _properties = [_properties mutableCopy];
//            _keyProperties = [_keyProperties mutableCopy];
        } else {
            _mutable = mutable;
            _properties = [_properties copy];
            _keyProperties = [_keyProperties copy];
        }
    }
}

- (void)addKeyPropertiesObject:(NSString *)object {
    if (self.mutable) {
        [(NSMutableArray *)_keyProperties addObject:object];
    }
}

- (void)setPropertiesObject:(id)object withKey:(NSString *)key {
    if (self.mutable) {
        [(NSMutableDictionary *)_properties setObject:object forKey:key];
    }
}

- (void)setName:(NSString *)name {
    if (![name isEqualToString:_name] && _mutable) {
        _name = [name copy];
    }
}

@end
