//
//  ODResource+CollectionFields.m
//  OIDataNorth
//
//  Created by ilya on 10/30/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "ODResource+CollectionFields.h"

#import "ODEntity.h"

@implementation ODResource (CollectionFields)

- (NSString *)guessMediumDescriptionProperty {
    // Guess by assigning a weight to every property.
    NSMutableDictionary *propertyWeight = [NSMutableDictionary new];
    NSMutableDictionary *propertyValues = [NSMutableDictionary new];
    [[self.childrenArray allObjects] enumerateObjectsUsingBlock:^(ODEntity *entity, NSUInteger idx, BOOL *stop) {
        if ([entity isKindOfClass:[ODResource class]] && entity.kind == ODResourceKindEntity) {
            [entity.localProperties enumerateKeysAndObjectsUsingBlock: ^(NSString *key, id obj, BOOL *stop) {
                float newWeight = [self weightAsMediumDescriptionOfValue:obj] + [self weightAsMediumDescriptionOfKey:key];
                float oldWeight = [propertyWeight[key] floatValue];
                propertyWeight[key] = @(newWeight + oldWeight);
                NSMutableSet *values = propertyValues[key];
                if (!values) {
                    propertyValues[key] = values = [NSMutableSet new];
                }
                [values addObject:obj];
            }];
        }
    }];
    
    if (!propertyWeight.count) return nil;
    for (NSString *key in propertyValues) {
        float newWeight = [propertyValues[key] count];
        float oldWeight = [propertyWeight[key] floatValue];
        propertyWeight[key] = @(newWeight + oldWeight);
    }
    
    propertyValues = nil; // drop ASAP
    
    // Sort our guesses.
    NSMutableArray *sortedProperties = [NSMutableArray new];
    [propertyWeight enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        [sortedProperties addObject:@[obj, key]];
    }];
    [sortedProperties sortUsingComparator: ^NSComparisonResult (NSArray *obj1, NSArray *obj2) {
        NSNumber *weight1 = obj1[0];
        NSNumber *weight2 = obj2[0];
        return [weight2 compare:weight1];
    }];
    
    // Now take the best guess.
    return sortedProperties[0][1];
}

// Try to answer a question: what is a good description?
- (float)weightAsMediumDescriptionOfValue:(id)propertyValue {
    float weight = 0;
    if ([propertyValue isKindOfClass:[NSString class]]) {
        // good description is a string
        weight += 0.5;
        // of the right size
        if ([propertyValue length] >= 4) weight += 0.1;
        if ([propertyValue length] >= 8) weight += 0.1;
        if ([propertyValue length] >= 16) weight += 0.1;
        if ([propertyValue length] >= 32) weight -= 0.1;
        if ([propertyValue length] >= 50) weight -= 0.1;
        if ([propertyValue length] >= 100) weight -= 0.1;
        // but not lowercase
        if ([[propertyValue lowercaseString] isEqualToString:propertyValue]) weight -= 0.1;
        // and not uppercase
        if ([[propertyValue lowercaseString] isEqualToString:propertyValue]) weight -= 0.15;
        // and readable
        if ([propertyValue rangeOfString:@" "].location != NSNotFound) weight += 0.05;
        if ([propertyValue rangeOfString:@"."].location != NSNotFound) weight -= 0.15;
        if ([propertyValue rangeOfString:@". "].location != NSNotFound) weight += 0.05;
        if ([propertyValue rangeOfString:@","].location != NSNotFound) weight -= 0.15;
        if ([propertyValue rangeOfString:@", "].location != NSNotFound) weight += 0.05;
        if ([propertyValue rangeOfString:@":"].location != NSNotFound) weight -= 0.15;
        if ([propertyValue rangeOfString:@": "].location != NSNotFound) weight += 0.05;
        if ([propertyValue rangeOfString:@"6"].location != NSNotFound) weight -= 0.05;
        if ([propertyValue rangeOfString:@"7"].location != NSNotFound) weight -= 0.05;
        if ([propertyValue rangeOfString:@"8"].location != NSNotFound) weight -= 0.05;
        if ([propertyValue rangeOfString:@"9"].location != NSNotFound) weight -= 0.05;
        if ([propertyValue rangeOfString:@"T0"].location != NSNotFound) weight -= 0.1;
    } else if ([propertyValue isKindOfClass:[NSNumber class]]) {
        // well, it can be a number
        weight += 0.25;
    }
    
    return weight;
}

- (float)weightAsMediumDescriptionOfKey:(NSString *)propertyName {
    float weight = 0;
    
    if ([propertyName rangeOfString:@"Name"].location != NSNotFound) weight += 0.5;
    if ([propertyName rangeOfString:@"name"].location != NSNotFound) weight += 0.2;
    
    if ([propertyName rangeOfString:@"Description"].location != NSNotFound) weight += 0.5;
    if ([propertyName rangeOfString:@"description"].location != NSNotFound) weight += 0.2;
    
    if ([propertyName rangeOfString:@"ID"].location != NSNotFound) weight += 0.2;
    if ([propertyName rangeOfString:@"id"].location != NSNotFound) weight += 0.1;
    
    return weight;
}

@end
