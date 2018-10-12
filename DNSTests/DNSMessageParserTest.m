//
//  DNSMessageParserTest.m
//  DNSTests
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSMessageDecoder.h>
#import <DNS/DNSAResourceRecord.h>
#import <DNS/DNSOPTResourceRecord.h>

@interface DNSMessageParserTest : XCTestCase

@end

@implementation DNSMessageParserTest

- (void)testParseQuery {
    uint8_t bytes[39] = {
        0x61, 0xA0, 0x01, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
        0x06, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x03, 0x63, 0x6F, 0x6D, 0x00,
        0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x29, 0x10, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00,
    };

    DNSMessageDecoder *decoder = [[DNSMessageDecoder alloc] init];
    [decoder decodeMessageInBuffer:bytes withLength:39];
    XCTAssertNotNil(decoder.message);
    DNSMessage *message = decoder.message;
    XCTAssertNotNil(message.header);
    XCTAssertNotNil(message.questions);
    XCTAssertNotNil(message.additionalRecords);
    XCTAssertNil(message.answers);
    XCTAssertNil(message.authorityRecords);

    DNSHeader *header = message.header;
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

    XCTAssertEqual(1, message.questions.count);
    DNSQuestion *question = message.questions.firstObject;
    XCTAssertEqualObjects(question.name, @"github.com");
    XCTAssertEqual(question.type, DNSTypeA);
    XCTAssertEqual(question.questionClass, DNSClassInternet);

    XCTAssertEqual(1, message.additionalRecords.count);
    DNSResourceRecord *resource = message.additionalRecords.firstObject;
    XCTAssertEqualObjects(resource.name, @".");
    XCTAssertEqual(resource.type, DNSTypeOPT);
    XCTAssertEqual(resource.resourceClass, 4096);
    XCTAssertEqual(resource.ttl, 0);
    XCTAssertEqual(resource.data.length, 0);
}

- (void)testParseAnswer {
    uint8_t bytes[71] = {
        0x61, 0xA0, 0x81, 0x80, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01,
        0x06, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x03, 0x63, 0x6F, 0x6D, 0x00,
        0x00, 0x01, 0x00, 0x01, 0xC0, 0x0C, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00,
        0x00, 0x0E, 0x00, 0x04, 0xC0, 0x1E, 0xFD, 0x71, 0xC0, 0x0C, 0x00, 0x01,
        0x00, 0x01, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x04, 0xC0, 0x1E, 0xFD, 0x70,
        0x00, 0x00, 0x29, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    };

    DNSMessageDecoder *decoder = [[DNSMessageDecoder alloc] init];
    [decoder decodeMessageInBuffer:bytes withLength:71];
    XCTAssertNotNil(decoder.message);
    DNSMessage *message = decoder.message;
    XCTAssertNotNil(message.header);
    XCTAssertNotNil(message.questions);
    XCTAssertNotNil(message.additionalRecords);
    XCTAssertNotNil(message.answers);
    XCTAssertNil(message.authorityRecords);

    DNSHeader *header = message.header;
    XCTAssertEqual(header.id, 0x61a0);
    XCTAssertEqual(header.isQuery, NO);
    XCTAssertEqual(header.opCode, DNSOPCodeQuery);
    XCTAssertEqual(header.authoritativeAnswer, NO);
    XCTAssertEqual(header.truncated, NO);
    XCTAssertEqual(header.recursionDesired, YES);
    XCTAssertEqual(header.recursionAvailable, YES);
    XCTAssertEqual(header.authenticatedData, NO);
    XCTAssertEqual(header.checkingDisabled, NO);
    XCTAssertEqual(header.responseCode, DNSRCodeNoError);
    XCTAssertEqual(header.questionCount, 1);
    XCTAssertEqual(header.answerRecordCount, 2);
    XCTAssertEqual(header.authorityRecordCount, 0);
    XCTAssertEqual(header.additionalRecordCount, 1);

    XCTAssertEqual(1, message.questions.count);
    DNSQuestion *question = message.questions.firstObject;
    XCTAssertEqualObjects(question.name, @"github.com");
    XCTAssertEqual(question.type, DNSTypeA);
    XCTAssertEqual(question.questionClass, DNSClassInternet);

    XCTAssertEqual(1, message.additionalRecords.count);
    DNSResourceRecord *resource = message.additionalRecords.firstObject;
    XCTAssertEqualObjects(resource.name, @".");
    XCTAssertEqual(resource.type, DNSTypeOPT);
    XCTAssertEqual(resource.resourceClass, 512);
    XCTAssertEqual(resource.ttl, 0);
    XCTAssertEqual(resource.data.length, 0);
    {
        DNSOPTResourceRecord *opt = [DNSOPTResourceRecord fromResource:resource];
        XCTAssertEqual(512, opt.udpPayloadSize);
        XCTAssertEqual(0x00, opt.version);
        XCTAssertEqual(0x00, opt.extendedRCode);
        XCTAssertFalse(opt.dnssecOK);
        opt.udpPayloadSize = 512;
        opt.extendedRCode = 0x00;
        opt.version = 0x00;
        opt.dnssecOK = NO;
    }

    resource = message.answers.firstObject;
    XCTAssertEqualObjects(resource.name, @"github.com");
    XCTAssertEqual(resource.type, DNSTypeA);
    XCTAssertEqual(resource.resourceClass, DNSClassInternet);
    XCTAssertEqual(resource.ttl, 14);
    {
        uint8_t expectedDataBytes[4] = { 0xc0, 0x1e, 0xfd, 0x71 };
        NSData *expectedData = [NSData dataWithBytes:expectedDataBytes length:4];
        XCTAssertEqualObjects(resource.data, expectedData);
        DNSAResourceRecord *aRecord = [DNSAResourceRecord fromResource:resource];
        XCTAssertEqualObjects(aRecord.ip.address, @"192.30.253.113");
    }

    resource = message.answers.lastObject;
    XCTAssertEqualObjects(resource.name, @"github.com");
    XCTAssertEqual(resource.type, DNSTypeA);
    XCTAssertEqual(resource.resourceClass, DNSClassInternet);
    XCTAssertEqual(resource.ttl, 14);
    {
        uint8_t expectedDataBytes[4] = { 0xc0, 0x1e, 0xfd, 0x70 };
        NSData *expectedData = [NSData dataWithBytes:expectedDataBytes length:4];
        XCTAssertEqualObjects(resource.data, expectedData);
        DNSAResourceRecord *aRecord = [DNSAResourceRecord fromResource:resource];
        XCTAssertEqualObjects(aRecord.ip.address, @"192.30.253.112");
    }
}

@end
