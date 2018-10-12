//
//  DNSLabelParserTest.m
//  DNSTests
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSLabelDecoder.h>

@interface DNSLabelDecoderTest : XCTestCase

@end

@implementation DNSLabelDecoderTest

- (void)testPlain {
    uint8_t bytes[13] = {
        0x03, 0x64, 0x6E, 0x73, 0x04, 0x76, 0x69, 0x74, 0x6F, 0x02, 0x69, 0x6F,
        0x00,
    };
    
    DNSLabelDecoder *decoder = [[DNSLabelDecoder alloc] init];
    uint32_t offset = 0;
    [decoder decodeLabelInBuffer:bytes withOffset:&offset andLength:13];
    XCTAssertNotNil(decoder.name);
    XCTAssertEqualObjects(decoder.name, @"dns.vito.io");
}

- (void)testSingleCompression {
    uint8_t bytes[25] = {
        0xC0, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x03, 0x64, 0x6E, 0x73, 0x04, 0x76, 0x69, 0x74, 0x6F, 0x02, 0x69, 0x6F,
        0x00,

    };
    
    DNSLabelDecoder *decoder = [[DNSLabelDecoder alloc] init];
    uint32_t offset = 0;
    [decoder decodeLabelInBuffer:bytes withOffset:&offset andLength:25];
    XCTAssertNotNil(decoder.name);
    XCTAssertEqualObjects(decoder.name, @"dns.vito.io");
}

- (void)testMultiCompressedLabel {
    uint8_t bytes[59] = {
        0x04, 0x76, 0x69, 0x74, 0x6F, 0xC0, 0x32, 0x27, 0x27, 0x27, 0x27, 0x27,
        0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27,
        0x27, 0x27, 0x27, 0x03, 0x64, 0x6E, 0x73, 0xC0, 0x00, 0x27, 0x27, 0x27,
        0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27,
        0x27, 0x27, 0x02, 0x69, 0x6F, 0x00, 0x27, 0x27, 0x27, 0x27, 0x27,

    };

    DNSLabelDecoder *decoder = [[DNSLabelDecoder alloc] init];
    uint32_t offset = 27;
    [decoder decodeLabelInBuffer:bytes withOffset:&offset andLength:59];
    XCTAssertNotNil(decoder.name);
    XCTAssertEqualObjects(decoder.name, @"dns.vito.io");
}

@end
