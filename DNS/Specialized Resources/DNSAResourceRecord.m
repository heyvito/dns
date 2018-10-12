//
//  DNSAResourceRecord.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSAResourceRecord.h"

@implementation DNSAResourceRecord

- (void)decodeFromResource:(DNSResourceRecord *)resource {
    self.ip = [IPAddress addressWithData:resource.data];
}

- (NSData *)encodeData {
    return [self.ip data];
}

- (id)copyWithZone:(NSZone *)zone {
    DNSAResourceRecord *copy = [super copyWithZone:zone];
    if(self.ip != nil) {
        copy.ip = [IPAddress addressWithData:[self.ip data]];
    }
    return copy;
}

@end
