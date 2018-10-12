//
//  DNSHeaderEncoder.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSHeaderEncoder.h"
#import "DNSUtils.h"

@implementation DNSHeaderEncoder

+ (NSData *)encode:(DNSHeader *)header {
    uint8_t buffer[12];
    uint32_t offset = 0;

    uint16_t flags = header.isQuery ? 0x00 : 0x01;
    flags <<= 4;
    flags |= (header.opCode & 0xF);
    flags <<= 1;
    flags |= header.authoritativeAnswer ? 0x01 : 0x00;
    flags <<= 1;
    flags |= header.truncated ? 0x01 : 0x00;
    flags <<= 1;
    flags |= header.recursionDesired ? 0x01 : 0x00;
    flags <<= 1;
    flags |= header.recursionAvailable ? 0x01 : 0x00;
    flags <<= 2;
    flags |= header.authenticatedData ? 0x01 : 0x00;
    flags <<= 1;
    flags |= header.checkingDisabled ? 0x01 : 0x00;
    flags <<= 4;
    flags |= header.responseCode & 0xF;

    dns_write_uint16_into(buffer, &offset, header.id);
    dns_write_uint16_into(buffer, &offset, flags);
    dns_write_uint16_into(buffer, &offset, header.questionCount);
    dns_write_uint16_into(buffer, &offset, header.answerRecordCount);
    dns_write_uint16_into(buffer, &offset, header.authorityRecordCount);
    dns_write_uint16_into(buffer, &offset, header.additionalRecordCount);
    return [NSData dataWithBytes:buffer length:12];
}

@end
