//
//  DNSResourceRecordDecoder.m
//  DNSTests
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSResourceRecordDecoder.h>

@interface DNSResourceRecordDecoderTest : XCTestCase

@end

@implementation DNSResourceRecordDecoderTest

- (void)testDecoderOPT {
    uint8_t buffer[11] = {
        0x00, 0x00, 0x29, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    };
    uint32_t offset = 0;

    DNSResourceRecordDecoder *decoder = [[DNSResourceRecordDecoder alloc] init];
    [decoder decodeResourceInBuffer:buffer withOffset:&offset andLength:11];

    DNSResourceRecord *resource = decoder.resource;

    XCTAssertEqualObjects(resource.name, @".");
    XCTAssertEqual(resource.type, DNSTypeOPT);
    XCTAssertEqual(resource.resourceClass, 4096);
    XCTAssertEqual(resource.ttl, 0);
    XCTAssertEqual(resource.data.length, 0);
}

- (void)testDecoderTypeA {
    uint8_t buffer[26] = {
        0x06, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x03, 0x63, 0x6F, 0x6D, 0x00,
        0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x04, 0xC0, 0x1E, 0xFD,
        0x71
    };
     uint32_t offset = 0;

    uint8_t expectedDataBytes[4] = { 0xc0, 0x1e, 0xfd, 0x71 };
    NSData *expectedData = [NSData dataWithBytes:expectedDataBytes length:4];

    DNSResourceRecordDecoder *decoder = [[DNSResourceRecordDecoder alloc] init];
    [decoder decodeResourceInBuffer:buffer withOffset:&offset andLength:26];

    DNSResourceRecord *resource = decoder.resource;

    XCTAssertEqualObjects(resource.name, @"github.com");
    XCTAssertEqual(resource.type, DNSTypeA);
    XCTAssertEqual(resource.resourceClass, DNSClassInternet);
    XCTAssertEqual(resource.ttl, 14);
    XCTAssertEqualObjects(resource.data, expectedData);
}

@end
