//
//  DNSHeaderDecoder.m
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSHeaderDecoder.h"
#import "DNSUtils.h"

typedef NS_ENUM(NSUInteger, SMState) {
    SMStateID,
    SMStateMetadata,
    SMStateQCount,
    SMStateACount,
    SMStateNSCount,
    SMStateARCount,
};

@implementation DNSHeaderDecoder

- (void)decodeHeaderInBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)bufferLength {

    uint8_t tmpBuf[2];
    DNSHeader *header = [[DNSHeader alloc] init];

    // Read ID
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    header.id = dns_uint16_from_bytes(tmpBuf);

    // Read Flags
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    uint16_t bytes = dns_uint16_from_bytes(tmpBuf);
    header.isQuery = dns_take_bits(bytes, 0, 1) == 0x00;
    header.opCode = dns_take_bits(bytes, 1, 4);
    header.authoritativeAnswer = dns_take_bits(bytes, 5, 1) == 0x01;
    header.truncated = dns_take_bits(bytes, 6, 1) == 0x01;
    header.recursionDesired = dns_take_bits(bytes, 7, 1) == 0x01;
    header.recursionAvailable = dns_take_bits(bytes, 8, 1) == 0x01;
    header.authenticatedData = dns_take_bits(bytes, 9, 1) == 0x01;
    header.checkingDisabled = dns_take_bits(bytes, 10, 1) == 0x01;
    header.responseCode = dns_take_bits(bytes, 11, 4);

    // Read QCount
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    header.questionCount = dns_uint16_from_bytes(tmpBuf);

    // Read ACount
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    header.answerRecordCount = dns_uint16_from_bytes(tmpBuf);

    // Read NSCount
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    header.authorityRecordCount = dns_uint16_from_bytes(tmpBuf);

    // Read ARCount
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    header.additionalRecordCount = dns_uint16_from_bytes(tmpBuf);

    self.header = header;
}

@end
