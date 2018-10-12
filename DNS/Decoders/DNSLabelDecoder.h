//
//  DNSLabelDecoder.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 DNSLabelDecoder is responsible for decoding DNS labels as defined by RFC1035.

 @link https://tools.ietf.org/html/rfc1035#section-3
 */
@interface DNSLabelDecoder : NSObject

/**
 Used to store result of a decoding operation, name either contains a name with
 labels separated by dots, or a single dot, representing the root level.
 */
@property (nonnull, nonatomic, retain) NSString *name;

/**
 Decodes labels into a name using the provided buffer, advancing the provided
 offset pointer. Length is provided as a mechanism to prevent corrupted or
 invalid data from reading more than allocated by the provided buffer
 (over-read).

 @param buffer Pointer to an array of bytes from which labels will be parsed
 from.
 @param offset Offset pointing to the next byte that will be read by the parsing
 facilities
 @param bufferLength Total length of provided buffer. Used to prevent over-read.
 */
- (void)decodeLabelInBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)bufferLength;

@end

NS_ASSUME_NONNULL_END
