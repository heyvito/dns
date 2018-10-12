//
//  DNSQuestionEncoder.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSQuestionEncoder.h"
#import "DNSLabelEncoder.h"
#import "DNSUtils.h"

@implementation DNSQuestionEncoder

+ (NSData *)encode:(DNSQuestion *)question {
    NSMutableData *data = [[NSMutableData alloc] init];
    [data appendData:[DNSLabelEncoder encode:question.name]];
    uint8_t buffer[4];
    uint32_t offset = 0;
    dns_write_uint16_into(buffer, &offset, question.type);
    dns_write_uint16_into(buffer, &offset, question.questionClass);
    [data appendBytes:buffer length:4];
    return data;
}

@end
