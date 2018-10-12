//
//  DNSHeaderEncoder.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNSHeaderEncoder : NSObject

/**
 Encodes a @c DNSHeader instance into an NSData object

 @param header Header to be encoded
 @return @c NSData instance containing the encoded header as specified by
 RFC1035
 */
+ (NSData *)encode:(nonnull DNSHeader *)header;

@end

NS_ASSUME_NONNULL_END
