//
//  DNSMessageDecoder.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSMessageDecoder.h"
#import "DNSHeaderDecoder.h"
#import "DNSQuestionDecoder.h"
#import "DNSResourceRecordDecoder.h"

@implementation DNSMessageDecoder

- (void)decodeMessageInBuffer:(uint8_t *)buffer withLength:(uint32_t)bufferLength {
    self.message = nil;
    DNSMessage *message = [[DNSMessage alloc] init];
    uint32_t offset = 0;

    message.header = [self decodeHeaderWithBuffer:buffer
                                       withOffset:&offset
                                        andLength:bufferLength];
    if(message.header == nil) {
        // TODO(vito): What to do here?
        return;
    }

    if(message.header.questionCount > 0) {
        message.questions = [self decodeQuestionsWithCount:message.header.questionCount
                                                    buffer:buffer
                                                withOffset:&offset
                                                 andLength:bufferLength];

        if(message.questions.count != message.header.questionCount) {
            // TODO(vito): What to do here?
            return;
        }
    }

    if(message.header.answerRecordCount > 0) {
        message.answers = [self decodeResourceRecordWithCount:message.header.answerRecordCount
                                                       buffer:buffer
                                                   withOffset:&offset
                                                    andLength:bufferLength];
        if(message.answers.count != message.header.answerRecordCount) {
            // TODO(vito): What to do here?
            return;
        }
    }

    if(message.header.authorityRecordCount > 0) {
        message.authorityRecords = [self decodeResourceRecordWithCount:message.header.authorityRecordCount
                                                       buffer:buffer
                                                   withOffset:&offset
                                                    andLength:bufferLength];
        if(message.authorityRecords.count != message.header.authorityRecordCount) {
            // TODO(vito): What to do here?
            return;
        }
    }

    if(message.header.additionalRecordCount > 0) {
        message.additionalRecords = [self decodeResourceRecordWithCount:message.header.additionalRecordCount
                                                                buffer:buffer
                                                            withOffset:&offset
                                                             andLength:bufferLength];
        if(message.additionalRecords.count != message.header.additionalRecordCount) {
            // TODO(vito): What to do here?
            return;
        }
    }

    self.message = message;
}

- (DNSHeader *)decodeHeaderWithBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)length {
    DNSHeaderDecoder *headerDecoder = [[DNSHeaderDecoder alloc] init];
    [headerDecoder decodeHeaderInBuffer:buffer
                             withOffset:offset
                              andLength:length];
    return headerDecoder.header;
}

- (NSArray<DNSQuestion *> *)decodeQuestionsWithCount:(int)count buffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)length {
    DNSQuestionDecoder *questionDecoder = [[DNSQuestionDecoder alloc] init];
    NSMutableArray *questionArray = [[NSMutableArray alloc] initWithCapacity:count];
    for(int i = 0; i < count; i++) {
        [questionDecoder decodeQuestionInBuffer:buffer
                                     withOffset:offset
                                      andLength:length];
        if(questionDecoder.question != nil) {
            [questionArray addObject:questionDecoder.question];
        }
    }
    return questionArray;
}

- (NSArray<DNSResourceRecord *> *)decodeResourceRecordWithCount:(int)count buffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)length {
    DNSResourceRecordDecoder *resourceDecoder = [[DNSResourceRecordDecoder alloc] init];
    NSMutableArray *resourceArray = [[NSMutableArray alloc] initWithCapacity:count];
    for(int i = 0; i < count; i++) {
        [resourceDecoder decodeResourceInBuffer:buffer
                                     withOffset:offset
                                      andLength:length];
        if(resourceDecoder.resource != nil) {
            [resourceArray addObject:resourceDecoder.resource];
        }
    }
    return resourceArray;
}

@end
