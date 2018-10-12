//
//  DNSMessageEncoderTest.m
//  DNSTests
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DNS/DNSMessageEncoder.h>
#import <DNS/DNSAResourceRecord.h>

@interface DNSMessageEncoderTest : XCTestCase

@end

@implementation DNSMessageEncoderTest

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

    DNSQuestion *question = [[DNSQuestion alloc] init];
    question.name = @"github.com";
    question.type = DNSTypeA;
    question.questionClass = DNSClassInternet;

    DNSAResourceRecord *a1 = [[DNSAResourceRecord alloc] init];
    a1.name = @"github.com";
    a1.ip = [IPAddress addressFromString:@"192.30.253.113"];
    a1.ttl = 14;
    a1.resourceClass = DNSClassInternet;
    a1.type = DNSTypeA;

    DNSAResourceRecord *a2 = [[DNSAResourceRecord alloc] init];
    a2.name = @"github.com";
    a2.ip = [IPAddress addressFromString:@"192.30.253.112"];
    a2.ttl = 14;
    a2.resourceClass = DNSClassInternet;
    a2.type = DNSTypeA;

    DNSMessage *message = [[DNSMessage alloc] init];
    message.header = header;
    message.questions = @[question];
    message.answers = @[a1, a2];

    DNSResourceRecord *resource = [[DNSResourceRecord alloc] init];
    resource.name = @".";
    resource.type = DNSTypeOPT;
    resource.resourceClass = 512;
    resource.ttl = 0;
    resource.data = nil;
    message.additionalRecords = @[resource];

    NSData *data = [DNSMessageEncoder encode:message];
    uint8_t bytes[91] = {
        0x61, 0xA0, 0x81, 0x80, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01,
        0x06, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x03, 0x63, 0x6F, 0x6D, 0x00,
        0x00, 0x01, 0x00, 0x01, 0x06, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x03,
        0x63, 0x6F, 0x6D, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x0E,
        0x00, 0x04, 0xC0, 0x1E, 0xFD, 0x71, 0x06, 0x67, 0x69, 0x74, 0x68, 0x75,
        0x62, 0x03, 0x63, 0x6F, 0x6D, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00,
        0x00, 0x0E, 0x00, 0x04, 0xC0, 0x1E, 0xFD, 0x70, 0x00, 0x00, 0x29, 0x02,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    };
    NSData *expectedBytes = [NSData dataWithBytes:bytes length:91];
    XCTAssertEqualObjects(data, expectedBytes);
}

@end
