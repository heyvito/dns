//
//  DNSQuestionDecoderTest.m
//  DNSTests
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSQuestionDecoder.h>

@interface DNSQuestionDecoderTest : XCTestCase

@end

@implementation DNSQuestionDecoderTest

- (void)testDecoder {
    uint8_t bytes[16] = {
        0x06, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x03, 0x63, 0x6f, 0x6d,
        0x00, 0x00, 0x01, 0x00, 0x01
    };
    uint32_t offset = 0;

    DNSQuestionDecoder *decoder = [[DNSQuestionDecoder alloc] init];
    [decoder decodeQuestionInBuffer:bytes withOffset:&offset andLength:16];

    XCTAssertNotNil(decoder.question);
    DNSQuestion *question = decoder.question;
    XCTAssertEqualObjects(question.name, @"github.com");
    XCTAssertEqual(question.type, DNSTypeA);
    XCTAssertEqual(question.questionClass, DNSClassInternet);
}

@end
