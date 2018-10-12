//
//  DNSCNAMEResourceRecord.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSCNAMEResourceRecord.h"

@implementation DNSCNAMEResourceRecord

- (void)decodeFromResource:(DNSResourceRecord *)resource {
    if(resource.data.length > 0) {
        uint8_t bytes[resource.data.length];
        [resource.data getBytes:bytes length:resource.data.length];
        DNSLabelDecoder *labelDecoder = [[DNSLabelDecoder alloc] init];
        uint32_t offset = 0;
        [labelDecoder decodeLabelInBuffer:bytes withOffset:&offset andLength:(uint32_t)resource.data.length];
        self.canonicalName = labelDecoder.name;
    }
}

- (NSData *)encodeData {
    return [DNSLabelEncoder encode:self.name];
}

- (id)copyWithZone:(NSZone *)zone {
    DNSCNAMEResourceRecord *copy = [super copyWithZone:zone];
    copy.canonicalName = [self.canonicalName copyWithZone:zone];
    return copy;
}

@end
