//
//  DNSRCode.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#ifndef DNSRCode_h
#define DNSRCode_h

// This takes 4 bits in the header.

typedef NS_ENUM(uint8_t, DNSRCode) {
    DNSRCodeNoError           = 0,
    DNSRCodeFormatError       = 1,
    DNSRCodeServerFailure     = 2,
    DNSRCodeNonExistentDomain = 3,
    DNSRCodeNotImplemented    = 4,
    DNSRCodeRefused           = 5,
    DNSRCodeYXDomain          = 6,
    DNSRCodeYXRRSet           = 7,
    DNSRCodeNXRRSet           = 8,
    DNSRCodeNotAuthorized     = 9,
    DNSRCodeNameNotInZone     = 10,
    DNSRCode11                = 11,
    DNSRCode12                = 12,
    DNSRCode13                = 13,
    DNSRCode14                = 14,
    DNSRCode15                = 15,
};

#endif /* DNSRCode_h */
