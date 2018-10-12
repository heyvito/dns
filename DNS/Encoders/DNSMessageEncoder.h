//
//  DNSMessageEncoder.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNSMessageEncoder : NSObject

/**
 Creates an internal copy of the provided @c DNSMessage, updates its header
 counters and encodes the whole message as specified by RFC1035

 @param message Message to be encoded
 @return A @c NSData instance containing the encoded byte sequence representing
 the DNS message
 */
+ (NSData *)encode:(DNSMessage *)message;

@end

NS_ASSUME_NONNULL_END
