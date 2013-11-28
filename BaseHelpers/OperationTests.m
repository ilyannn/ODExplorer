//
//  OperationTests.m
//  ODExplorerLib
//
//  Created by ilya on 11/26/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "OSOperation.h"
#import "OSBlockStep.h"

@interface OperationTests : XCTestCase

@end

@implementation OperationTests

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

- (void)testSimpleOperation
{
    __block NSInteger value = 2;
    
    OSOperation *op = [OSOperation new];
    [op addLastOperationStep:[OSBlockStep step:@"value = 3" withBlock:^NSError *(id op) {
        value = 3;
        return nil;
    }]];

    XCTAssertTrue(value == 2, @"value has not been set");
    
    [op start];
    [op waitUntilFinished];
    
    XCTAssertTrue(value == 3, @"value has not been correctly set");
}

@end
