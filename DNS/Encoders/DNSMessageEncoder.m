//
//  DNSMessageEncoder.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSMessageEncoder.h"
#import "DNSHeaderEncoder.h"
#import "DNSQuestionEncoder.h"

@implementation DNSMessageEncoder

+ (NSData *)encode:(DNSMessage *)message {
    message = [message copy];
    message.header.questionCount = message.questions.count;
    message.header.answerRecordCount = message.answers.count;
    message.header.authorityRecordCount = message.authorityRecords.count;
    message.header.additionalRecordCount = message.additionalRecords.count;

    NSMutableData *data = [[NSMutableData alloc] init];
    [data appendData:[DNSHeaderEncoder encode:message.header]];
    for(DNSQuestion *question in message.questions) {
        [data appendData:[DNSQuestionEncoder encode:question]];
    }
    for(DNSResourceRecord *record in message.answers) {
        [data appendData:[record encode]];
    }
    for(DNSResourceRecord *record in message.authorityRecords) {
        [data appendData:[record encode]];
    }
    for(DNSResourceRecord *record in message.additionalRecords) {
        [data appendData:[record encode]];
    }
    return data;
}

@end
