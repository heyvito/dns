//
//  DNSLabelEncoder.m
//  DNS
//
//  Created by Victor Gama on 12/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSLabelEncoder.h"

@implementation DNSLabelEncoder

+ (NSData *)encode:(NSString *)name {
    if([name isEqualToString:@"."]) {
        uint8_t bytes[1] = { 0x0 };
        return [NSData dataWithBytes:bytes length:1];
    }
    NSArray *labels = [name componentsSeparatedByString:@"."];
    NSMutableData *data = [[NSMutableData alloc] init];
    for(NSString *label in labels) {
        uint8_t bytes[label.length + 1];
        bytes[0] = (uint8_t)label.length;
        const char *string = [label cStringUsingEncoding:NSASCIIStringEncoding];
        memcpy(bytes + 1, string, label.length);
        [data appendBytes:bytes length:label.length + 1];
    }
    uint8_t bytes[1] = { 0x0 };
    [data appendBytes:bytes length:1];
    return data;
}

@end
