
//
//  ODStructuredType_Mutable.h
//  OIDataNorth
//
//  Created by ilya on 11/9/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@interface ODStructuredType ()

- (instancetype)initMutableWithName:(NSString *)name;
@property (getter = isMutable, nonatomic) BOOL mutable;

- (void)addKeyPropertiesObject:(NSString *)object;
- (void)setPropertiesObject:(id)object withKey:(NSString *)key;

@property (readwrite, copy) NSString *name;

@end
