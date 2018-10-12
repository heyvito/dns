//
//  DNSQuestion.m
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSQuestion.h"

@implementation DNSQuestion

- (id)copyWithZone:(NSZone *)zone {
    DNSQuestion *copy = [[[self class] alloc] init];
    copy.name = [self.name copyWithZone:zone];
    copy.type = self.type;
    copy.questionClass = self.questionClass;
    return copy;
}

@end
