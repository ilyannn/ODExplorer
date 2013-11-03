//
//  ODMetadataSource.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODMetadataModel.h"
#import "ODTypeLibrary.h"
#import "ODEntityType.h"

#import "ODAssociationEnd.h"
#import "ODMetadataParsingContext.h"

@interface ODMetadataModel ()
@end

@implementation ODMetadataModel 

- (instancetype)initWithData:(NSData *)contents typeLibrary:(ODTypeLibrary *)library {
    if (self = [super init]) {
        if (contents) [self updateWithData:contents];
        _typeLibrary = library;
        _entitySets = [NSMutableDictionary new];
        _associations = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)init {
    return [self initWithData:nil typeLibrary:[ODTypeLibrary shared]];
}

- (void)updateWithData:(NSData *)contents {
    ODMetadataParsingContext *context = [ODMetadataParsingContext new];
    context.delegate = self;

    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:contents];
    parser.delegate = context;
    [parser parse];
}


- (void)startParsingSchema:(ODMetadataParsingContext *)context {
    context.schemeNamespace = context.attributes[@"Namespace"];
}

- (void)startParsingEntitySet:(ODMetadataParsingContext *)context {
    NSString *name = context.attributes[@"Name"];
    NSString *type = context.attributes[@"Type"];
    if (name && type) {
        self.entitySets[name] = type;
    }
}


#pragma mark - Entities

- (void)startParsingEntityType:(ODMetadataParsingContext *)context {
    context.entityType = [[ODEntityType alloc] initWithName:context.qualifiedName];
}

- (void)startParsingKey:(ODMetadataParsingContext *)context {
    context.currentlyKeys = YES;
}

- (void)startParsingPropertyRef:(ODMetadataParsingContext *)context {
    if (context.currentlyKeys && context.qualifiedName) {
        [context.entityType.keyProperties addObject:context.qualifiedName];
    }
}

- (void)finishParsingKey:(ODMetadataParsingContext *)context {
    context.currentlyKeys = NO;
}

- (void)parsePropertyWithAttributes:(ODMetadataParsingContext *)context {
    NSString *name = attributes[@"Name"];
    
    if ([name rangeOfString:@"."].location == NSNotFound) {
        name = [NSString stringWithFormat:@"%@.%@", parsingNamespace, name];
    }
    
    ODType *type = [self.typeLibrary uniqueTypeFor:attributes[@"Type"]];
    if (name && type) {
        parsingEntityType.attributeProperties[name] = type;
    }
}

- (void)endParseEntityType {
    if (parsingEntityType) {
        [self.typeLibrary registerType:parsingEntityType];
    }
    parsingEntityType = nil;
}


#pragma mark - Associations

- (void)parseAssociationWithAttributes:(NSDictionary *)attributes {
    parsingAssociationName = attributes[@"Name"];
}

- (void)parseEndWithAttributes:(NSDictionary *)attributes {
    ODAssociationEnd *end = [ODAssociationEnd new];
    end.associationName = parsingAssociationName;
    end.roleName = attributes[@"Role"];
    end.multiplicity = attributes[@"Multiplicity"];
    end.typeName = attributes[@"Type"];
    self.associations[end.key] = end;
}

- (void)endParseAssociation {
    parsingAssociationName = nil;
}

@end
