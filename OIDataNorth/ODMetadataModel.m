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

#import "NSArray+Functional.h"

@interface ODMetadataModel ()

@end

@implementation ODMetadataModel 

- (instancetype)initWithData:(NSData *)contents typeLibrary:(ODTypeLibrary *)library {
    if (self = [super init]) {
        if (contents) [self updateWithData:contents];
        _typeLibrary = library;
        _entitySets = [NSMutableDictionary new];
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
    
    // Fill in types for navigation attributes.
    for (ODEntityType *entityType in context.parsedEntityTypes) {
        
        [self.typeLibrary addTypesByNameObject:entityType];

        NSArray *navigationProperties = [[[entityType properties] allKeys] arrayByFiltering:^BOOL(NSString *key) {
            return ![entityType.properties[key] isKindOfClass:[ODType class]];
        }];

        [navigationProperties enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            ODAssociationEnd *target = self.typeLibrary.associationEnds[entityType.properties[key]];
            ODType *type = !target ? nil : [self.typeLibrary uniqueTypeFor:target.typeName collection:target.collection];
            [entityType.properties setValue:type forKey:key];
        }];
        
    }

    [[self.entitySets allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        self.entitySets[key] = [self.typeLibrary uniqueTypeFor:self.entitySets[key]];
    }];

    self.schemaNamespace = context.schemaNamespace;
}

#pragma mark - Parsing

- (void)startParsingSchema:(ODMetadataParsingContext *)context {
    context.schemaNamespace = context.attributes[@"Namespace"];
}

- (void)startParsingEntitySet:(ODMetadataParsingContext *)context {
    NSString *name = context.attributes[@"Name"];
    NSString *type = context.attributes[@"EntityType"];
    if (name && type) {
        self.entitySets[name] = type;
    }
}


#pragma mark Entities

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

- (void)startParsingProperty:(ODMetadataParsingContext *)context {
    ODType *type = [self.typeLibrary uniqueTypeFor:context.attributes[@"Type"]];
    if (context.qualifiedName && type && context.entityType) {
        context.entityType.properties[context.qualifiedName] = type;
    }
}

- (void)finishParsingEntityType:(ODMetadataParsingContext *)context {
    if (context.entityType) {
        [context.parsedEntityTypes addObject:context.entityType];
    }
    context.entityType = nil;
}

- (void)startParsingNavigationProperty:(ODMetadataParsingContext *)context {
    NSArray *key = [ODAssociationEnd keyForAssociation:context.attributes[@"Relationship"]
                                                  role:context.attributes[@"ToRole"]];
    NSString *name = context.attributes[@"Name"];
    if (name && key) {
        context.entityType.properties[name] = key;
    }
}

#pragma mark Associations

- (void)startParsingAssociation:(ODMetadataParsingContext *)context  {
    context.associationName = context.qualifiedName;
}

- (void)startParsingEnd:(ODMetadataParsingContext *)context  {
    if (context.associationName) {
        ODAssociationEnd *end = [ODAssociationEnd new];
        end.associationName = context.associationName;
        end.roleName = context.attributes[@"Role"];
        end.multiplicity = context.attributes[@"Multiplicity"];
        end.typeName = context.attributes[@"Type"];
        [self.typeLibrary addAssociationEndsObject:end];
    }
}

- (void)finishParsingAssociation:(ODMetadataParsingContext *)context  {
    context.associationName = nil;
}

@end
