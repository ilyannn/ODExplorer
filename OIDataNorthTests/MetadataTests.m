//
//  MetadataTests.m
//  OIDataNorth
//
//  Created by ilya on 11/4/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ODMetadataOperation.h"
#import "NorthwindService.h"
#import "ODTypeLibrary.h"
#import "ODType.h"
#import "NSArray+Functional.h"

@interface MetadataTests : XCTestCase

@end

@implementation MetadataTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    ODMetadataOperation *op = [ODMetadataOperation operationWithResource:[NorthwindService unique]];
    [op start];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTypeNamesMatch
{
    [[ODTypeLibrary shared].types enumerateKeysAndObjectsUsingBlock:^(id key, ODType *obj, BOOL *stop) {
        NSLog(@"%@ -> %@", key, obj);
        if ([key rangeOfString:@"."].location != NSNotFound) {
            XCTAssertEqualObjects(key, [obj name], @"Types are kind of wrong");
        }
    }];
}

- (void)testTypesAdded {
    NSArray *north = [[[ODTypeLibrary shared].types allValues] arrayByFiltering:^BOOL(ODType *type) {
        return [type.name hasPrefix:@"Northwind"];
    }];
    XCTAssert(north.count, @"Didn't read entity types for some reason.");
}

@end
