//
//  DNSHeaderEncoderTest.m
//  DNSTests
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSHeaderEncoder.h>

@interface DNSHeaderEncoderTest : XCTestCase

@end

@implementation DNSHeaderEncoderTest

- (void)testEncoder {
    DNSHeader *header = [[DNSHeader alloc] init];
    header.id = 0x61A0;
    header.isQuery = NO;
    header.opCode = DNSOPCodeQuery;
    header.authoritativeAnswer = NO;
    header.truncated = NO;
    header.recursionAvailable = YES;
    header.recursionDesired = YES;
    header.authenticatedData = NO;
    header.checkingDisabled = NO;
    header.responseCode = DNSRCodeNoError;
    header.questionCount = 1;
    header.answerRecordCount = 2;
    header.additionalRecordCount = 1;
    NSData *data = [DNSHeaderEncoder encode:header];
    uint8_t expectedBytes[12] = {
        0x61, 0xA0, 0x81, 0x80, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01,
    };
    NSData *expectedData = [NSData dataWithBytes:expectedBytes length:12];
    XCTAssertEqualObjects(data, expectedData);

}

@end
