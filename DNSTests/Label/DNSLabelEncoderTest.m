//
//  DNSLabelEncoderTest.m
//  DNSTests
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSLabelEncoder.h>

@interface DNSLabelEncoderTest : XCTestCase

@end

@implementation DNSLabelEncoderTest

- (void)testLabelEncoder {
    uint8_t expectedBytes[13] = {
        0x03, 0x64, 0x6E, 0x73, 0x04, 0x76, 0x69, 0x74, 0x6F, 0x02, 0x69, 0x6F,
        0x00,
    };
    NSString *label = @"dns.vito.io";
    NSData *data = [DNSLabelEncoder encode:label];
    NSData *expectedData = [NSData dataWithBytes:expectedBytes length:13];
    XCTAssertEqualObjects(data, expectedData);
}

- (void)testEmptyLabel {
    uint8_t expectedBytes[1] = {
        0x00,
    };
    NSString *label = @".";
    NSData *data = [DNSLabelEncoder encode:label];
    NSData *expectedData = [NSData dataWithBytes:expectedBytes length:1];
    XCTAssertEqualObjects(data, expectedData);
}

@end
