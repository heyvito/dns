//
//  DNSCNAMEResourceRecord.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <DNS/DNS.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSCNAMEResourceRecord : DNSResourceRecord

@property (nullable, nonatomic, retain) NSString *canonicalName;

@end

NS_ASSUME_NONNULL_END
