//
//  DNSOPCode.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#ifndef DNSOPCode_h
#define DNSOPCode_h

typedef NS_ENUM(uint16_t, DNSOPCode) {
    DNSOPCodeQuery          = 0,
    DNSOPCodeInverseQuery   = 1,
    DNSOPCodeStatus         = 2,
    DNSOPCode3              = 3,
    DNSOPCodeNotify         = 4,
    DNSOPCodeUpdate         = 5,
    DNSOPCode6              = 6,
    DNSOPCode7              = 7,
    DNSOPCode8              = 8,
    DNSOPCode9              = 9,
    DNSOPCode10             = 10,
    DNSOPCode11             = 11,
    DNSOPCode12             = 12,
    DNSOPCode13             = 13,
    DNSOPCode14             = 14,
    DNSOPCode15             = 15,
};

#endif /* DNSOPCode_h */
