//
//  DNSClass.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#ifndef DNSClass_h
#define DNSClass_h

typedef NS_ENUM(uint16_t, DNSClass) {
    DNSClassInternet = 1,
    DNSClassCSNET    = 2,
    DNSClassCHAOS    = 3,
    DNSClassHesiod   = 4,
    DNSClassNone     = 254,
    DNSClassAny      = 255,
};

#endif /* DNSClass_h */
