//
//  ODMetadataParsingContext.h
//  OIDataNorth
//
//  Created by ilya on 11/4/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODStructuredType.h"

@interface ODataParsingContext : NSObject <NSXMLParserDelegate>

@property     (weak) id delegate;

@property     NSDictionary *attributes;
@property     NSString *schemaNamespace;
@property     NSString *associationName;
@property     ODStructuredType *entityType;
@property     (getter = isCurrentlyKeys) BOOL currentlyKeys;
@property     NSMutableArray *parsedEntityTypes;

@property (readonly) NSString *qualifiedName;
@end
