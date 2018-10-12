//
//  DNSQuestionEncoderTest.m
//  DNSTests
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSQuestionEncoder.h>

@interface DNSQuestionEncoderTest : XCTestCase

@end

@implementation DNSQuestionEncoderTest

- (void)testEncoder {
    DNSQuestion *question = [[DNSQuestion alloc] init];
    question.name = @"github.com";
    question.type = DNSTypeA;
    question.questionClass = DNSClassInternet;
    NSData *data = [DNSQuestionEncoder encode:question];

    uint8_t expectedBytes[16] = {
        0x06, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x03, 0x63, 0x6F, 0x6D, 0x00,
        0x00, 0x01, 0x00, 0x01,
    };
    NSData *expectedData = [NSData dataWithBytes:expectedBytes length:16];
    XCTAssertEqualObjects(data, expectedData);
}

@end
