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
 OCRequireInputTypeOrNil(NSNumber);

 NSNumber *value = @([input integerValue] + self.increment);
    // we will send maxint on purpose :)
    NSAssert(self.multiplicity < NSIntegerMax, @"That's way too much!");
    
    for (NSUInteger index = 0; index < self.multiplicity; index++) {
        [self send: value];
    }
    
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Channel that increments a value by %d and sends result %d times",
            self.increment, self.multiplicity];
}

- (NSString *)inputDescription {
    return @"NSNumber *";
}

- (NSString *)outputDescription {
    return @"NSNumber *";
}

@end

@interface TotalChannel : OCChannel
@end

@implementation TotalChannel {
    NSInteger _total;
}

- (void)setUp {
    _total = 100;
}

- (void)process:(id)input {
    OCRequireInputTypeOrNil(NSNumber);

    _total += [input integerValue];
}

- (void)tearDown {
    [self send:@(_total)];
}

- (NSString *)description {
    return @"Channel that computes a total value";
}

- (NSString *)inputDescription {
    return @"NSNumber *";
}

- (NSString *)outputDescription {
    return @"NSNumber *";
}

@end

@interface SaveChannel : OCChannel
- (instancetype)initWithRef:(NSInteger *)ref;
@property NSInteger *saveRef;

@end

@implementation SaveChannel
- (instancetype)initWithRef:(NSInteger *)ref {
    if (self = [super init]) {
        self.saveRef = ref;
    }
    return self;
}

- (NSString *)description {
    return @"Channel that saves incoming values";
}

- (void) process:(NSNumber *)input {
    OCRequireInputType(NSNumber);
    *self.saveRef = [input integerValue];
}

- (NSString *)inputDescription {
    return @"NSNumber *";
}

- (NSString *)outputDescription {
    return @"void";
}

@end

@interface IncrementOperation : OCOperation
- (instancetype)initWithIncrements:(NSArray *)increments multiplicities:(NSArray *)multiplicities;
@end

@implementation IncrementOperation

- (id)initWithIncrements:(NSArray *)increments multiplicities:(NSArray *)multiplicities {
    
    if (self = [super init]) {

        [increments enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
            IncrementChannel *channel = [IncrementChannel new];
            channel.increment = [obj integerValue];
            channel.multiplicity = multiplicities.count <= idx ? 1 : [multiplicities[idx] integerValue];
            [self addOutputChannel:channel];
        }];
        
        [self addOutputChannel: [TotalChannel new]];

    }
    return self;
}

@end

@interface OperationTests : XCTestCase

@end

@implementation OperationTests

- (void)testSmallExample
{
    NSInteger total = NSIntegerMin;
    
    IncrementOperation *operation = [[IncrementOperation alloc] initWithIncrements:@[@2, @3] multiplicities:@[@5, @3]];
    [operation addOutputChannel:[[SaveChannel alloc] initWithRef:&total]];
    
    [operation start];
    [operation waitUntilFinished];
    XCTAssertTrue(total == 100 + 5 * 3 * (2 + 3), @"Not the right answer!");
}

- (void)testLargeExample
{
    NSInteger total = NSIntegerMin;
    
    IncrementOperation *operation = [[IncrementOperation alloc] initWithIncrements:@[@2, @3, @7] multiplicities:@[@50, @30, @10]];
    operation.input = @10;
    [operation addOutputChannel:[[SaveChannel alloc] initWithRef:&total]];
    
//    CFAbsoluteTime timeBefore = CFAbsoluteTimeGetCurrent();
    
    [operation start];
    
//    CFTimeInterval intervalStarted = CFAbsoluteTimeGetCurrent() - timeBefore;
    
    [operation waitUntilFinished];
    
//    CFTimeInterval intervalFinished = CFAbsoluteTimeGetCurrent() - timeBefore;
    
    XCTAssertTrue(total == 100 + 50 * 30 * 10 * (10 + 2 + 3 + 7), @"Not the right answer!");
    
//    NSLog(@"Testing large number of chunks took %f, %f", intervalStarted, intervalFinished);
}

- (void)testInputValidation {
    XCTAssertTrue([[[IncrementOperation alloc] initWithIncrements:@[@2] multiplicities:nil]
                     synchronouslyPerformFor:@"string"] .code == kOCChannelErrorInvalidInput,
                  @"Should produce an input validation error");
}

- (void)testInternalException {
    XCTAssertTrue([[[IncrementOperation alloc] initWithIncrements:@[@2] multiplicities:@[@(NSIntegerMax)]]
                   synchronouslyPerformFor:@10] .code == kOCChannelErrorInternalException,
                  @"Should produce an exception (assertion fail)");
}

- (void)testDescription {
    IncrementOperation *operation = [[IncrementOperation alloc] initWithIncrements:@[@1, @2, @3] multiplicities:nil];
    NSString *description = [operation description];
    for (NSString *fragment in @[@"total", @"increment", @"NSNumber"]) {
        XCTAssertTrue([description rangeOfString:fragment].location != NSNotFound, @"Description isn't good enough");
    }
}

@end
