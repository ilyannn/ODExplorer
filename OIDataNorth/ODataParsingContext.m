//
//  ODMetadataParsingContext.m
//  OIDataNorth
//
//  Created by ilya on 11/4/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//


#import "ODataParsingContext.h"
#import "ODStructuredType_Mutable.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation ODataParsingContext

- (id)init
{
    self = [super init];
    if (self) {
        _parsedEntityTypes = [NSMutableArray new];
    }
    return self;
}

- (NSString *)qualifiedName {
    NSString *name = self.attributes[@"Name"];
    
    if ([name rangeOfString:@"."].location == NSNotFound) {
        name = [NSString stringWithFormat:@"%@.%@", self.schemaNamespace, name];
    }
    
    return name;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

//    NSLog(@"<%@>", elementName);
    self.attributes = attributeDict;
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"startParsing%@:", elementName]);

    id delegate = self.delegate;
    if ([delegate respondsToSelector:selector]) {
        [delegate performSelector:selector withObject:self];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
//    NSLog(@"</%@>", elementName);
    self.attributes = nil;
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"finishParsing%@:", elementName]);

    id delegate = self.delegate;
    if ([delegate respondsToSelector:selector]) {
        [delegate performSelector:selector withObject:self];
    }
}

    
@end
