//
//  OperationMainQueueTests.m
//  ODExplorerLib
//
//  Created by ilya on 12/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@import XCTest;

#import "OCChannel.h"
#import "OCOperation.h"


@interface MainQueueChannel : OCChannel
@property NSUInteger mainCount;
@end

@implementation MainQueueChannel

- (BOOL)requiresMainThread {
    return YES;
}

- (void)setUp {
    self.mainCount += !![NSThread isMainThread];
}

- (void)tearDown {
    self.mainCount += !![NSThread isMainThread];
}

- (void)process:(id)input {
    self.mainCount += !![NSThread isMainThread];
}

- (NSString *)description {
    return @"Channel that requires main queue";
}


@end

@interface OperationMainQueueTests : XCTestCase

@end

@implementation OperationMainQueueTests

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

- (void)testMainQueueOperation {
    MainQueueChannel *channel = [MainQueueChannel new];

    OCOperation *op = [OCOperation new];
    [op addOutputChannel:channel];
    [op start];
    
    while ([[NSOperationQueue mainQueue] operations].count)  {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
    
    XCTAssertTrue(channel.mainCount == 3,  @"Only main thread operations should occur");
}

@end
