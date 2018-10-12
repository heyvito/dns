//
//  DNSResourceRecord.m
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSResourceRecord.h"
#import "DNSLabelEncoder.h"
#import "DNSUtils.h"

@implementation DNSResourceRecord

+ (instancetype)fromResource:(DNSResourceRecord *)resource {
    DNSResourceRecord *instance = [[self alloc] init];
    [instance copyFromResource:resource];
    return instance;
}

- (void)copyFromResource:(DNSResourceRecord *)resource {
    self.name = [resource.name copy];
    self.type = resource.type;
    self.resourceClass = resource.resourceClass;
    self.ttl = resource.ttl;
    [self decodeFromResource:resource];
}

- (void)decodeFromResource:(DNSResourceRecord *)resource { }

- (NSData *)encode {
    NSMutableData *data = [[NSMutableData alloc] init];
    [data appendData:[DNSLabelEncoder encode:self.name]];

    uint8_t buffer[10];
    uint32_t offset = 0;
    dns_write_uint16_into(buffer, &offset, self.type);
    dns_write_uint16_into(buffer, &offset, self.resourceClass);
    dns_write_uint32_into(buffer, &offset, self.ttl);

    NSData *recordData = [self encodeData];
    dns_write_uint16_into(buffer, &offset, (uint16_t)recordData.length);

    [data appendBytes:buffer length:10];
    if(recordData.length > 0) {
        [data appendData:recordData];
    }
    return data;
}

- (NSData *)encodeData {
    return self.data;
}

- (id)copyWithZone:(NSZone *)zone {
    DNSResourceRecord *copy = [[[self class] alloc] init];
    copy.name = [self.name copyWithZone:zone];
    copy.type = self.type;
    copy.resourceClass = self.resourceClass;
    copy.ttl = self.ttl;
    copy.data = [self.data copyWithZone:zone];
    return copy;
}

@end
