//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSData+Base64.h"
#import "NSArray+ODHFunctional.h"
#import "ODHLazyMutableArray.h"

@interface HelpersTests : XCTestCase <LazyMutableArrayDelegate>

@end

@implementation HelpersTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFunctional {
    NSNumber *result = [[[@[@1, @3, @6, @11] arrayByMapping:^id(NSNumber *x) {
        return @(x.integerValue * 2);
    }] arrayByFiltering:^BOOL(NSNumber *x) {
        return x.integerValue < 20;
    }] objectByReducing:^id(NSNumber *x, NSNumber *y) {
        return @(x.integerValue + y.integerValue);
    }];
    
    XCTAssertEqualObjects(result, @20, @"Arithmetic operations chained with functional methods.");
}

- (void)testBase64 {
    NSDictionary *pairs = @{ @"VGhpcyBpcyBhIFRFU1Qgc3RyaW5nIQ==" : @"This is a TEST string!",
                             @"0KHRgtGA0L7QutCwINGBINGB0LjQvNCy0L7Qu9Cw0LzQuCBVbmljb2RlLg==" :
                                 @"Строка с символами Unicode."
                             };
    
    [pairs enumerateKeysAndObjectsUsingBlock:^(NSString *encoded, NSString *decoded, BOOL *stop) {
        NSData *data1 = [NSData dataFromBase64String:encoded];
        NSData *data2 = [decoded dataUsingEncoding:NSUTF8StringEncoding];
        XCTAssertEqualObjects(data1, data2, @"Ooops, our base64 decoding doesn't seem to work for decoding %@ -> %@",
                              encoded, decoded);

        NSString *encoded1 = [data2 base64EncodedString];
        XCTAssertEqualObjects(encoded1, encoded, @"Ooops, our base64 decoding doesn't seem to work for encoding %@ -> %@",
                              decoded, encoded);
    }];
}

- (void)testLazyMutableCorrectness {
    ODHLazyMutableArray *lazy = [[ODHLazyMutableArray alloc] initWithDelegate:self contents:@[@0, @10, @20]];
    
    XCTAssertEqual(lazy.count, (unsigned)3, @"Just like regular array count");

    lazy.count = 2; // can set count
    lazy[1] = @1; // correct assignment
//    lazy[3] = @5; // beyond boundary, nop
    
    XCTAssertEqualObjects([lazy lastObject], @1, @"Setting objects, retrieving objects, -lastObject");
    
    lazy.count = 20;
    XCTAssertEqualObjects(lazy[10], @10, @"Calling the delegate");
    
    [lazy enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, @(idx), @"Enumeration using block + delegate");
    }];
    
    lazy.count = 0; // drops all elements
    XCTAssertTrue(!lazy.size, @"Should have dropped the storage");
    
    id singleton = [NSMutableArray new];
    [lazy addObject:singleton];
    
    __weak id weakSingleton = singleton;
    singleton = [NSMutableDictionary new];
    [lazy addObject:singleton];
    
    XCTAssertNotNil(weakSingleton, @"Held by lazy array");
    XCTAssertTrue(lazy.count == 2, @"Cleaning and adding objects");
    
    [lazy cleanWeakElements]; // drop element with index 0
    
    XCTAssertNotNil(singleton, @"Not dropped by lazy array");
    XCTAssertNil(weakSingleton, @"Dropped by lazy array");
    
    XCTAssertTrue(lazy.count == 2, @"Cleaning weak elements doesn't change count");
    XCTAssertEqualObjects(lazy[0], @0, @"Now the delegate fills the array");
    XCTAssertTrue(lazy[1] == singleton, @"Strongly referenced elements must not be dropped");
}

- (void)testPointerArray {
    // See http://stackoverflow.com/a/19884472/115200 for details.
    __weak id weakobject;
    @autoreleasepool
    {
        NSPointerArray *parray = [NSPointerArray strongObjectsPointerArray];
        {
            id object = [NSObject new];
            [parray addPointer:(__bridge void*)object];
            weakobject = object;
        }
        parray = nil;
    }
    XCTAssertTrue(!weakobject, @"weakobject still exists");
}

- (void)testLazyMutableMemorySemantics {
    
    // Insert two objects into lazy array, one held weakly, one held strongly.
    
    NSMutableArray * lazy = // [NSMutableArray new];
                            [[ODHLazyMutableArray alloc] initWithDelegate:self];

    id singleton = [NSMutableArray new];
    [lazy addObject:singleton];

    __weak id weakSingleton = singleton;
    singleton = [NSMutableDictionary new];
    [lazy addObject:singleton];
    
    XCTAssertNotNil(weakSingleton, @"Held by lazy array");
    XCTAssertTrue(lazy.count == 2, @"Cleaning and adding objects");
    
    // Needs release, see my question at http://stackoverflow.com/q/19883056/115200
    @autoreleasepool
    {
        XCTAssertEqual(weakSingleton, lazy[0], @"Correct element storage");
        XCTAssertEqual(singleton, lazy[1], @"Correct element storage");
    }
    
    lazy = nil;
    
    XCTAssertNotNil(singleton, @"Not dropped by lazy array");
    XCTAssertNil(weakSingleton, @"Dropped by lazy array");
    
}

-(NSArray *)array:(ODHLazyMutableArray *)lazy missingObjectsFromIndex:(NSUInteger)index {
    return @[@(index), @(index + 1), @(index + 2)];
}


@end
