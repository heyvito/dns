//
//  DNSHeaderParserTest.m
//  DNSTests
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSHeaderDecoder.h>

@interface DNSHeaderDecoderTest : XCTestCase

@end

@implementation DNSHeaderDecoderTest

- (void)testDecoder {
    uint8_t bytes[12] = {
        0x61, 0xA0, 0x01, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01
    };

    uint32_t offset = 0;
    DNSHeaderDecoder *decoder = [[DNSHeaderDecoder alloc] init];
    [decoder decodeHeaderInBuffer:bytes withOffset:&offset andLength:12];
    XCTAssertNotNil(decoder.header);
    DNSHeader *header = decoder.header;
    XCTAssertEqual(header.id, 0x61a0);
    XCTAssertEqual(header.isQuery, YES);
    XCTAssertEqual(header.opCode, DNSOPCodeQuery);
    XCTAssertEqual(header.authoritativeAnswer, NO);
    XCTAssertEqual(header.truncated, NO);
    XCTAssertEqual(header.recursionDesired, YES);
    XCTAssertEqual(header.recursionAvailable, NO);
    XCTAssertEqual(header.authenticatedData, NO);
    XCTAssertEqual(header.checkingDisabled, YES);
    XCTAssertEqual(header.responseCode, DNSRCodeNoError);
    XCTAssertEqual(header.questionCount, 1);
    XCTAssertEqual(header.answerRecordCount, 0);
    XCTAssertEqual(header.authorityRecordCount, 0);
    XCTAssertEqual(header.additionalRecordCount, 1);
}

@end
