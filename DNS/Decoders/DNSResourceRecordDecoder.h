//
//  DNSResourceRecordDecoder.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSResourceRecord.h"

/*
 0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                                               |
 /                                               /
 /                     NAME                      /
 /                                               /
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                     TYPE                      |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                     CLASS                     |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                     TTL                       |
 |                                               |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                   RDLENGTH                    |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--|
 /                    RDATA                      /
 /                                               /
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 */

NS_ASSUME_NONNULL_BEGIN


/**
 Responsible for decoding a DNS Resource Record into an @c DNSResourceRecord
 object. Resource Record is defined in RFC1035.

 @link https://tools.ietf.org/html/rfc1035#section-3.2
 */
@interface DNSResourceRecordDecoder : NSObject

/**
 After decoding is complete, @c resource retains an instance to a
 @c DNSResourceRecord
 */
@property (nullable, nonatomic, retain) DNSResourceRecord *resource;

/**
 Decodes the provided buffer into a @c DNSResourceRecord, advancing the provided
 offset pointer. Length is provided as a mechanism to prevent corrupted or
 invalid data from reading more than allocated by the provided buffer
 (over-read).

 @param buffer Pointer to an array of bytes from which the resource will be
 parsed from.
 @param offset Offset pointing to the next byte that will be read by the parsing
 facilities
 @param bufferLength Total length of provided buffer. Used to prevent over-read.
 */
- (void)decodeResourceInBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)bufferLength;

@end

NS_ASSUME_NONNULL_END
