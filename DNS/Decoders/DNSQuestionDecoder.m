//
//  DNSQuestionDecoder.m
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSQuestionDecoder.h"
#import "DNSLabelDecoder.h"
#import "DNSUtils.h"

@implementation DNSQuestionDecoder

- (void)decodeQuestionInBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)bufferLength {
    uint8_t tmpBuf[2];
    DNSLabelDecoder *labelDecoder = [[DNSLabelDecoder alloc] init];
    DNSQuestion *question = [[DNSQuestion alloc] init];

    [labelDecoder decodeLabelInBuffer:buffer withOffset:offset andLength:bufferLength];
    question.name = labelDecoder.name;
    if(question.name == nil) {
        // TODO(vito): What to do here?
        return;
    }

    // Read Type
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    question.type = dns_uint16_from_bytes(tmpBuf);

    // Read Class
    for(int i = 0; i < 2; i++) {
        tmpBuf[i] = buffer[dns_increment_offset(offset)];
    }
    question.questionClass = dns_uint16_from_bytes(tmpBuf);
    self.question = question;

}

@end
