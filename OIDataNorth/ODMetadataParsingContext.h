//
//  ODMetadataParsingContext.h
//  OIDataNorth
//
//  Created by ilya on 11/4/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODEntityType.h"

@interface ODMetadataParsingContext : NSObject <NSXMLParserDelegate>

@property     (weak) id delegate;

@property     NSDictionary *attributes;
@property     NSString *schemeNamespace;
@property     NSString *associationName;
@property     ODEntityType *entityType;
@property     (getter = isCurrentlyKeys) BOOL currentlyKeys;

@property (readonly) NSString *qualifiedName;

@end
