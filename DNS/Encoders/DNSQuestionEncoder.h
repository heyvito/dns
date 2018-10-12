//
//  DNSQuestionEncoder.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSQuestion.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNSQuestionEncoder : NSObject

/**
 Encodes a @c DNSQuestion instance into a byte sequence defined by RFC1035

 @param question The question to be encoded
 @return A NSData instance containing the encoded byte sequence
 */
+ (NSData *)encode:(nonnull DNSQuestion *)question;

@end

NS_ASSUME_NONNULL_END
