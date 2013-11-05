//
//  ODMetadataSource.h
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@class ODTypeLibrary;

@interface ODMetadataModel : NSObject

@property (readonly) ODTypeLibrary *typeLibrary;

- (instancetype)initWithData:(NSData *)contents typeLibrary:(ODTypeLibrary *)library;
- (void)updateWithData:(NSData *)contents;

@property NSString *schemaNamespace;
@property NSMutableDictionary *entitySets;

@end
