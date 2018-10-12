//
//  DNSOPTResourceRecord.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSOPTResourceRecord.h"

@implementation DNSOPTResourceRecord

- (void)decodeFromResource:(DNSResourceRecord *)resource {
    self.udpPayloadSize = self.resourceClass;
    self.extendedRCode = self.ttl & 0xFF;
    self.version = (self.ttl >> 8) & 0xFF;
    uint8_t flags = (self.ttl >> 16) & 0xFFFF;
    self.dnssecOK = (flags >> 15) == 0x01;
}

- (NSData *)encode {
    self.resourceClass = self.udpPayloadSize;
    uint32_t ttl = self.extendedRCode & 0xFF;
    ttl <<= 8;
    ttl |= self.version & 0xFF;
    ttl <<= 8;
    ttl |= self.dnssecOK ? 0x01 : 0x00;
    ttl <<= 15;
    self.ttl = ttl;
    return [super encode];
}

- (id)copyWithZone:(NSZone *)zone {
    DNSOPTResourceRecord *copy = [super copyWithZone:zone];
    copy.udpPayloadSize = self.udpPayloadSize;
    copy.extendedRCode = self.extendedRCode;
    copy.version = self.version;
    copy.dnssecOK = self.dnssecOK;
    return copy;
}


@end
