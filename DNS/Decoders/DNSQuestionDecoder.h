//
//  DNSQuestionDecoder.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSQuestion.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Responsible for decoding a DNS question as defined by RFC1035

 @link https://tools.ietf.org/html/rfc1035#section-4.1.2
 */
@interface DNSQuestionDecoder : NSObject

/**
 After decoding is complete, @c question retains an instance to a @c DNSQuestion
 */
@property (nullable, nonatomic, retain) DNSQuestion *question;

/**
 Decodes the provided buffer into a @c DNSQuestion, advancing the provided
 offset pointer. Length is provided as a mechanism to prevent corrupted or
 invalid data from reading more than allocated by the provided buffer
 (over-read).

 @param buffer Pointer to an array of bytes from which the question will be
 parsed from.
 @param offset Offset pointing to the next byte that will be read by the parsing
 facilities
 @param bufferLength Total length of provided buffer. Used to prevent over-read.
 */
- (void)decodeQuestionInBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)bufferLength;

@end

NS_ASSUME_NONNULL_END
