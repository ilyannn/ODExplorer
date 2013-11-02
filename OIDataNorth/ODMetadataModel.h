//
//  ODMetadataSource.h
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@interface ODMetadataModel : NSObject

- (instancetype)initWithData:(NSData *)contents;

@property NSMutableDictionary *entitySets;
@property NSMutableDictionary *entityTypes;
@property NSMutableDictionary *functions;

@end
