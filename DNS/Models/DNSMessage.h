//
//  DNSMessage.h
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNSHeader.h"
#import "DNSQuestion.h"
#import "DNSResourceRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNSMessage : NSObject <NSCopying>

/**
 Header retains basic information about the message, such as type and resources
 length
 */
@property(nullable, nonatomic, retain) DNSHeader *header;

/**
 Retains a list of questions contained in the message
 */
@property(nullable, nonatomic, retain) NSArray<DNSQuestion *> *questions;


/**
 Retains a list of answers contained in the message
 */
@property(nullable, nonatomic, retain) NSArray<DNSResourceRecord *> *answers;


/**
 Retains a list of authority records contained in the message
 */
@property(nullable, nonatomic, retain) NSArray<DNSResourceRecord *> *authorityRecords;


/**
 Retains a list of additional resource records contained in the message
 */
@property(nullable, nonatomic, retain) NSArray<DNSResourceRecord *> *additionalRecords;

@end

NS_ASSUME_NONNULL_END
