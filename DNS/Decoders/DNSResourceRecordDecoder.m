//
//  DNSResourceRecordDecoder.m
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSResourceRecordDecoder.h"
#import "DNSLabelDecoder.h"
#import "DNSUtils.h"

@implementation DNSResourceRecordDecoder

- (void)decodeResourceInBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)bufferLength {
    if(*offset >= bufferLength) {
        return;
    }

    DNSResourceRecord *resource = [[DNSResourceRecord alloc] init];

    DNSLabelDecoder *decoder = [[DNSLabelDecoder alloc] init];
    [decoder decodeLabelInBuffer:buffer withOffset:offset andLength:bufferLength];
    if(decoder.name == nil) {
        // TODO(vito): What to do here?
        return;
    }
    resource.name = decoder.name;

    uint8_t *tmpBuf = malloc(2);

    // Read Type
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    resource.type = dns_uint16_from_bytes(tmpBuf);

    // Read Class
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    resource.resourceClass = dns_uint16_from_bytes(tmpBuf);

    // Read TTL
    for(int i = 0; i < 4; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    resource.ttl = dns_uint32_from_bytes(tmpBuf);

    // Read Lenght
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    uint16_t dataSize = dns_uint16_from_bytes(tmpBuf);
    free(tmpBuf);
    tmpBuf = NULL;

    if(dataSize == 0) {
        resource.data = [NSData data];
    } else {
        // Copy data to tmpbuf, feed it to NSData
        tmpBuf = malloc(dataSize);
        memcpy(tmpBuf, buffer + *offset, dataSize);
        *offset = *offset + dataSize;
        resource.data = [NSData dataWithBytes:tmpBuf length:dataSize];
    }

    self.resource = resource;
    free(tmpBuf);
}

@end
