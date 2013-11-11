//
//  ODMetadataSource.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODataModel.h"
#import "ODTypeLibrary.h"
#import "ODStructuredType.h"

#import "ODAssociationEnd.h"
#import "ODataParsingContext.h"

#import "NSArray+ODHFunctional.h"

#import "ODStructuredType_Mutable.h"

@interface ODataModel ()

@end

@implementation ODataModel 

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
    ODataParsingContext *context = [ODataParsingContext new];
    context.delegate = self;

    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:contents];
    parser.delegate = context;
    [parser parse];
    
    for (ODStructuredType *entityType in context.parsedEntityTypes) {
        [self.typeLibrary addTypesByNameObject:entityType];
    }
    
    // Fill in types for navigation attributes.
    for (ODStructuredType *entityType in context.parsedEntityTypes) {
    
        NSArray *navigationProperties = [[[entityType properties] allKeys] arrayByFiltering:^BOOL(NSString *key) {
            return ![entityType.properties[key] isKindOfClass:[ODType class]];
        }];

        [navigationProperties enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            ODAssociationEnd *target = self.typeLibrary.associationEnds[entityType.properties[key]];
            ODType *type = !target ? nil : [self.typeLibrary uniqueTypeFor:target.typeName collection:target.collection];
            [entityType.properties setValue:type forKey:key];
        }];
        
        // Finalize it.
        entityType.mutable = NO;
    }

    [[self.entitySets allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        self.entitySets[key] = [self.typeLibrary uniqueTypeFor:self.entitySets[key]];
    }];

    self.schemaNamespace = context.schemaNamespace;
}

#pragma mark - Parsing

- (void)startParsingSchema:(ODataParsingContext *)context {
    context.schemaNamespace = context.attributes[@"Namespace"];
}

- (void)startParsingEntitySet:(ODataParsingContext *)context {
    NSString *name = context.attributes[@"Name"];
    NSString *type = context.attributes[@"EntityType"];
    if (name && type) {
        self.entitySets[name] = type;
    }
}


#pragma mark Entities

- (void)startParsingEntityType:(ODataParsingContext *)context {
    context.entityType = [[ODStructuredType alloc] initMutableWithName:context.qualifiedName];
}

- (void)startParsingKey:(ODataParsingContext *)context {
    context.currentlyKeys = YES;
}

- (void)startParsingPropertyRef:(ODataParsingContext *)context {
    if (context.currentlyKeys && context.qualifiedName) {
        [context.entityType addKeyPropertiesObject:context.qualifiedName];
    }
}

- (void)finishParsingKey:(ODataParsingContext *)context {
    context.currentlyKeys = NO;
}

- (void)startParsingProperty:(ODataParsingContext *)context {
    ODType *type = [self.typeLibrary uniqueTypeFor:context.attributes[@"Type"]];
    if (context.qualifiedName && type && context.entityType) {
        [context.entityType setPropertiesObject:type withKey: context.qualifiedName];
    }
}

- (void)finishParsingEntityType:(ODataParsingContext *)context {
    if (context.entityType) {
        [context.parsedEntityTypes addObject:context.entityType];
    }
    context.entityType = nil;
}

- (void)startParsingNavigationProperty:(ODataParsingContext *)context {
    NSArray *propertyKey = [ODAssociationEnd keyForAssociation:context.attributes[@"Relationship"]
                                                  role:context.attributes[@"ToRole"]];
    NSString *name = context.attributes[@"Name"];
    if (name && propertyKey) {
        [context.entityType setPropertiesObject:propertyKey withKey:name];
    }
}

#pragma mark Associations

- (void)startParsingAssociation:(ODataParsingContext *)context  {
    context.associationName = context.qualifiedName;
}

- (void)startParsingEnd:(ODataParsingContext *)context  {
    if (context.associationName) {
        ODAssociationEnd *end = [ODAssociationEnd new];
        end.associationName = context.associationName;
        end.roleName = context.attributes[@"Role"];
        end.multiplicity = context.attributes[@"Multiplicity"];
        end.typeName = context.attributes[@"Type"];
        [self.typeLibrary addAssociationEndsObject:end];
    }
}

- (void)finishParsingAssociation:(ODataParsingContext *)context  {
    context.associationName = nil;
}

@end
