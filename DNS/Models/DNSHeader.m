//
//  DNSHeader.m
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSHeader.h"

@implementation DNSHeader

- (id)copyWithZone:(NSZone *)zone {
    DNSHeader *copy = [[[self class] alloc] init];
    copy.id = self.id;
    copy.isQuery = self.isQuery;
    copy.opCode = self.opCode;
    copy.authoritativeAnswer = self.authoritativeAnswer;
    copy.truncated = self.truncated;
    copy.recursionDesired = self.recursionDesired;
    copy.recursionAvailable = self.recursionAvailable;
    copy.authenticatedData = self.authenticatedData;
    copy.checkingDisabled = self.checkingDisabled;
    copy.responseCode = self.responseCode;
    copy.questionCount = self.questionCount;
    copy.answerRecordCount = self.answerRecordCount;
    copy.authorityRecordCount = self.authorityRecordCount;
    copy.additionalRecordCount = self.additionalRecordCount;
    return copy;
}

@end
