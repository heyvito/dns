//
//  DNSResourceRecord.h
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
 /                                               /
 /                      NAME                     /
 |                                               |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                      TYPE                     |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                     CLASS                     |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                      TTL                      |
 |                                               |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 |                   RDLENGTH                    |
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--|
 /                     RDATA                     /
 /                                               /
 +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 */

NS_ASSUME_NONNULL_BEGIN

/**
 Represents a generic DNS Resource Record. Generic resource records can be
 transformed into specialized classes by using their utility methods.

 @discussion A generic resource can be transformed into a specialized one. After asserting a
 @c DNSResourceRecord contains a @c type value of @c DNSTypeA, the user can
 initialize a new @c DNSAResourceRecord using
 @code
 [DNSAResourceRecord fromResource:genericResource];
 @endcode
 Please refer to the README for a commplete list of specific resource records.
 */
@interface DNSResourceRecord : NSObject <NSCopying>

/**
 Name represents the owner name, i.e., the name of the node to which this
 resource record pertains.
 */
@property (nonnull, nonatomic, retain) NSString *name;

/**
 Represents the record type, such as DNSTypeAAAA, or DNSTypeSOA
 */
@property (nonatomic) DNSType type;

/**
 Class of the resource being queried. The "resource" prefix has been added since
 class is a reserved keyword.
 */
@property (nonatomic) DNSClass resourceClass;

/**
 The time in seconds that the record may be cached. A value of 0 indicates the
 record should not be cached.
 */
@property (nonatomic) uint32_t ttl;

/**
 Data represents the bytes that compose the answer body. These bytes may be
 decoded into a known type based on the value of `type`.
 */
@property (nonatomic, nullable, retain) NSData *data;


/**
 Initializes a specialized resource class based on a generic resource record.

 @param resource Generic Resource Record to parse from
 @return A new instance of the resource record, using the provided base resource
 data to extract specialized data from
 */
+ (instancetype)fromResource:(nonnull DNSResourceRecord *)resource;

- (void)decodeFromResource:(nonnull DNSResourceRecord *)resource;

- (NSData *)encode;

- (NSData *)encodeData;

@end

NS_ASSUME_NONNULL_END
