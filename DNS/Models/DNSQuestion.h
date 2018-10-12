//
//  DNSQuestion.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSType.h"
#import "DNSClass.h"

/*
                               1  1  1  1  1  1
 0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                                               |
 /                     QNAME                     /
 /                                               /
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                     QTYPE                     |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                     QCLASS                    |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 */

NS_ASSUME_NONNULL_BEGIN

@interface DNSQuestion : NSObject <NSCopying>

/**
 Domain name being queried
 */
@property (nonatomic, nonnull, retain) NSString *name;

/**
 Resource record being queried
 */
@property (nonatomic) DNSType type;

/**
 Class of the resource being queried. The "question" prefix has been added since
 class is a reserved keyword.
 */
@property (nonatomic) DNSClass questionClass;

@end

NS_ASSUME_NONNULL_END
