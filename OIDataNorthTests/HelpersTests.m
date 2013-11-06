//
//  HelpersTests.m
//  OIDataNorth
//
//  Created by ilya on 11/2/13.
//  Copyright (c) 2013 Ilya Nikokoshev. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSData+Base64.h"
#import "ODPrimitiveTypeDateTime.h"

@interface HelpersTests : XCTestCase

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

- (void)testJSONDates {
    ODPrimitiveTypeDateTime *example = [ODPrimitiveTypeDateTime new];

    NSDate *date1 = [example.dateTimeFormatterV2 dateFromString:@"/Date(1310669017000)/"];
    XCTAssertNotNil(date1, @"Formatter didn't decode the JSON date at all");

    NSDate *date2 = [example.dateTimeFormatterV3 dateFromString:@"2011-07-14T18:43:37"];
    XCTAssertEqualObjects(date1, date2, @"Oops, date formatters don't seem to decode correctly");
}

@end
