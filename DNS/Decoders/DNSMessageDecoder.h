//
//  DNSMessageDecoder.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSMessage.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Responsible for decoding a given bufer into a complete DNS Message. This
 library assumes that the provided buffer contains a complete DNS message, as
 its reassembly is determined by the transport protocol.
 It is important to notice that this library does not implement state machines,
 but assumes all provided messages are complete.
 */
@interface DNSMessageDecoder : NSObject

/**
 Retains a @c DNSMessage instance after decoding is complete
 */
@property (nullable, nonatomic, retain) DNSMessage *message;

/**
 Decodes the provided buffer into a @c DNSMessage object retained by @c message.

 @param buffer Buffer to read the message from
 @param bufferLength Length of the provided buffer. Used to avoid over-read.
 */
- (void)decodeMessageInBuffer:(uint8_t *)buffer withLength:(uint32_t)bufferLength;

@end

NS_ASSUME_NONNULL_END
