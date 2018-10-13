//
//  DNS.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ip/ip.h>

//! Project version number for DNS.
FOUNDATION_EXPORT double DNSVersionNumber;

//! Project version string for DNS.
FOUNDATION_EXPORT const unsigned char DNSVersionString[];

#import <DNS/DNSClass.h>
#import <DNS/DNSOPCode.h>
#import <DNS/DNSRCode.h>
#import <DNS/DNSType.h>
#import <DNS/DNSHeader.h>
#import <DNS/DNSQuestion.h>
#import <DNS/DNSResourceRecord.h>
#import <DNS/DNSMessage.h>

#import <DNS/DNSAResourceRecord.h>
#import <DNS/DNSOPTResourceRecord.h>
#import <DNS/DNSCNAMEResourceRecord.h>

#import <DNS/DNSLabelDecoder.h>
#import <DNS/DNSHeaderDecoder.h>
#import <DNS/DNSQuestionDecoder.h>
#import <DNS/DNSResourceRecordDecoder.h>
#import <DNS/DNSMessageDecoder.h>

#import <DNS/DNSLabelEncoder.h>
#import <DNS/DNSHeaderEncoder.h>
#import <DNS/DNSQuestionEncoder.h>
#import <DNS/DNSMessageEncoder.h>
