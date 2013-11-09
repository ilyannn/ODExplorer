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
#import "ODNominalType.h"
#import "NSArray+Functional.h"
#import "ODStructuredType.h"
#import "ODPrimitiveType.h"
#import "ODPrimitiveTypeDateTime.h"

@interface TypesTests : XCTestCase
@property ODTypeLibrary *library;
@end

@implementation TypesTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!self.library) {
        ODMetadataOperation *op = [ODMetadataOperation operationWithResource:[NorthwindService unique]];
        [op start];
        self.library = [ODTypeLibrary shared];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTypeClassHierarhy
{
    [self.library.typesByName enumerateKeysAndObjectsUsingBlock:^(id key, ODNominalType *obj, BOOL *stop) {
        
        if ([obj isNotImplemented]) {
            NSLog(@"Warning: tests contain a type %@ that is not implemented.", obj);
        }

        XCTAssert(![obj isCollection], @"Collection type %@ shoudln't be here", obj);
        XCTAssertEqual([obj isNotImplemented] + [obj isPrimitive] + [obj isComplex] + [obj isEntity],
                       1, @"Nominal type %@ must be one of 3 kinds", obj);
        
        if ([obj isKindOfClass:[ODPrimitiveType class]]) {
            XCTAssert([obj isPrimitive], @"Primitive type %@ is inconsistent", obj);
        } else if ([obj isKindOfClass:[ODStructuredType class]]) {
            
            XCTAssert(![obj isPrimitive], @"Structured type %@ is inconsistent", obj);
            
            for (ODType *linked in [(ODStructuredType *)obj properties]) {
                XCTAssertEqual([obj isNotImplemented] + [obj isCollection] + [obj isPrimitive]
                               + [obj isComplex] + [obj isEntity], 1, @"Type %@ not one of 4 kinds", linked);
            }
        
        }
    }];
    
}

- (void)testTypeNamesMatch
{
    [self.library.typesByName enumerateKeysAndObjectsUsingBlock:^(id key, ODNominalType *obj, BOOL *stop) {
        NSLog(@"%@ -> %@", key, obj);
        if ([key rangeOfString:@"."].location != NSNotFound) {
            XCTAssertEqualObjects(key, [obj name], @"Type %@: name is wrong", obj);
        } else {
            XCTAssertEqualObjects(([NSString stringWithFormat:@"Edm.%@", key]),
                                  [obj name], @"Primitive type %@: name is wrong", obj);
        }
    }];
}

- (void)testNorthwindTypesAdded
{
    NSArray *north = [[self.library.typesByName allValues] arrayByFiltering:^BOOL(ODNominalType *type) {
        return [type.name hasPrefix:@"Northwind"];
    }];
    XCTAssert(north.count, @"Didn't read entity types for some reason.");
}

- (void)testJSONDates {
    ODPrimitiveTypeDateTime *example = [ODPrimitiveTypeDateTime new];
    
    NSDate *date1 = [example.dateTimeFormatterV2 dateFromString:@"/Date(1310669017000)/"];
    XCTAssertNotNil(date1, @"Formatter didn't decode the JSON date at all");
    
    NSDate *date2 = [example.dateTimeFormatterV3 dateFromString:@"2011-07-14T18:43:37"];
    XCTAssertEqualObjects(date1, date2, @"Oops, date formatters don't seem to decode correctly");
}


@end
