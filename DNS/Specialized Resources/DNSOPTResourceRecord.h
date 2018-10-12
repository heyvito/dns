//
//  DNSOPTResourceRecord.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <DNS/DNS.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSOPTResourceRecord : DNSResourceRecord

@property (nonatomic) uint16_t udpPayloadSize;
@property (nonatomic) uint8_t extendedRCode;
@property (nonatomic) uint8_t version;
@property (nonatomic) BOOL dnssecOK;

@end

NS_ASSUME_NONNULL_END
