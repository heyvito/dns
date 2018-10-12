//
//  DNSMessage.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSMessage.h"

@implementation DNSMessage

- (id)copyWithZone:(NSZone *)zone {
    DNSMessage *copy = [[[self class] alloc] init];
    copy.header = [self.header copyWithZone:zone];
    copy.questions = [self.questions copyWithZone:zone];
    copy.answers = [self.answers copyWithZone:zone];
    copy.authorityRecords = [self.authorityRecords copyWithZone:zone];
    copy.additionalRecords = [self.additionalRecords copyWithZone:zone];
    return copy;
}

@end
