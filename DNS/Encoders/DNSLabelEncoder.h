//
//  DNSLabelEncoder.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSLabelEncoder : NSObject

/**
 Encodes a server name into labels as specified by RFC1035

 @param name string containing a server name
 @return A @c NSData instance containing the provided string in the expected
 label format
 */
+ (NSData *)encode:(nonnull NSString *)name;

@end

NS_ASSUME_NONNULL_END
