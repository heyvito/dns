//
//  DNSAResourceRecord.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <DNS/DNS.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSAResourceRecord : DNSResourceRecord

@property (nonnull, nonatomic, retain) IPAddress *ip;

@end

NS_ASSUME_NONNULL_END
