//
//  OCJSONParserChannel.m
//  ODExplorerLib
//
//  Created by ilya on 12/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import "OCJSONParserChannel.h"

#import <YAJLiOS/YAJL.h>

@interface OCJSONParserChannel () <YAJLParserDelegate>

@end

@implementation OCJSONParserChannel {
    YAJLParser *parser;
}

- (void)setUp {
    parser = [[YAJLParser alloc] initWithParserOptions:YAJLParserOptionsAllowComments];
    parser.delegate = self;
}

- (NSString *)inputDescription {
    return @"NSData *";
}

- (NSString *)outputDescription {
    return @"void";
}

- (void)process:(id)input {
    OCRequireInputType(NSData);
    [parser parse:input];
    [self error:parser.parserError];
}

- (void)parserDidEndArray:(YAJLParser *)parser {
    
}

- (void)parserDidEndDictionary:(YAJLParser *)parser {
    
}

- (void)parserDidStartArray:(YAJLParser *)parser {
    
}

- (void)parserDidStartDictionary:(YAJLParser *)parser {
    
}

- (void)parser:(YAJLParser *)parser didAdd:(id)value {
    
}

- (void)parser:(YAJLParser *)parser didMapKey:(NSString *)key {
    
}

@end
