//
//  OperationTests.m
//  ODExplorerLib
//
//  Created by ilya on 11/29/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

@import XCTest;

#import "OCOperation.h"

@interface IncrementChannel : OCChannel
@property NSInteger increment;
@property NSUInteger multiplicity;
@end

@implementation IncrementChannel

- (void)process:(NSNumber *)input {
    for (NSUInteger index = 0; index < self.multiplicity; index++) {
        [self send: @([input integerValue] + self.increment)];
    }
}

@end

@interface TotalChannel : OCChannel
@property NSInteger *totalRef;
- (void)setup;
@end

@implementation TotalChannel {
    NSInteger _total;
}

- (void)setup {
    _total = 100;
}

- (void)process:(id)input {
    _total += [input integerValue];
}

- (void)teardown {
    *self.totalRef = _total;
}

@end

@interface IncrementOperation : OCOperation
@property TotalChannel *totalChannel;
- (instancetype)initWithIncrements:(NSArray *)increments multiplicities:(NSArray *)multiplicities;
@end

@implementation IncrementOperation

- (id)initWithIncrements:(NSArray *)increments multiplicities:(NSArray *)multiplicities {
    if (self = [super init]) {
        [increments enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
            IncrementChannel *channel = [IncrementChannel new];
            channel.increment = [obj integerValue];
            channel.multiplicity = multiplicities.count <= idx ? 1 : [multiplicities[idx] integerValue];
            [self addLastChannel:channel];
        }];
        [self addLastChannel: (self.totalChannel = [TotalChannel new])];
    }
    return self;
}

@end

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

- (void)testSmallExample
{
    NSInteger total = NSIntegerMin;
    
    IncrementOperation *operation = [[IncrementOperation alloc] initWithIncrements:@[@2, @3] multiplicities:@[@5, @3]];
    operation.totalChannel.totalRef = &total;
    
    [operation start];
    [operation waitUntilFinished];
    XCTAssertTrue(total == 100 + 5 * 3 * (2 + 3), @"Not the right answer!");
}

- (void)testLargeExample
{
    NSInteger total = NSIntegerMin;
    
    IncrementOperation *operation = [[IncrementOperation alloc] initWithIncrements:@[@2, @3, @7] multiplicities:@[@50, @30, @10]];
    operation.input = @10;
    operation.totalChannel.totalRef = &total;
    
    CFAbsoluteTime timeBefore = CFAbsoluteTimeGetCurrent();
    CFTimeInterval intervalNOOP = CFAbsoluteTimeGetCurrent() - timeBefore;
    
    [operation start];
    
    CFTimeInterval intervalStarted = CFAbsoluteTimeGetCurrent() - timeBefore;
    
    [operation waitUntilFinished];
    
    CFTimeInterval intervalFinished = CFAbsoluteTimeGetCurrent() - timeBefore;
    
    XCTAssertTrue(total == 100 + 50 * 30 * 10 * (10 + 2 + 3 + 7), @"Not the right answer!");
    
    // silence unused var warning
    XCTAssertTrue(intervalNOOP + intervalFinished + intervalStarted > 0, @"Time goes in one direction!");
}

@end
