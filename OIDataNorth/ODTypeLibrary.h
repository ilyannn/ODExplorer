//
//  ODTypeLibrary.h
//  OIDataNorth
//
//  Created by ilya on 11/3/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODType;

@interface ODTypeLibrary : NSObject

+ (ODTypeLibrary *)shared;

@property (readonly) NSDictionary *types;

/// This returns an existing class or creates new one.
- (void)registerType:(ODType *)type;
- (ODType *)uniqueTypeFor:(NSString *)typeName;

@end
