//
//  DNSLabelDecoder.m
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#import "DNSLabelDecoder.h"
#import "DNSUtils.h"

typedef NS_ENUM(NSUInteger, SMState) {
    SMStateLength,
    SMStateData,
    SMStatePointer,
};

@implementation DNSLabelDecoder {
    SMState state;
    uint8_t *buffer;
    uint32_t bufferSize;
    uint32_t bufferOffset;
    NSMutableArray<NSString *> *labels;
}

- (instancetype)init {
    if((self = [super init]) != nil) {
        self->buffer = NULL;
        self->labels = [[NSMutableArray alloc] init];
        [self resetBufferToSize:0];
    }
    return self;
}

- (void)resetBufferToSize:(uint32_t)size {
    free(self->buffer);
    self->bufferSize = size;
    self->bufferOffset = 0;
    if(size > 0) {
        self->buffer = malloc(size);
    }
}

- (void)compileNameAndReset {
    if(self->labels.count == 0) {
        self.name = @".";
    } else {
        self.name = [self->labels componentsJoinedByString:@"."];
    }
    [self->labels removeAllObjects];
    [self resetBufferToSize:0];
    self->state = SMStateLength;
}

- (void)decodeLabelInBuffer:(uint8_t *)buffer withOffset:(uint32_t *)offset andLength:(uint32_t)bufferLength {
    while(true) {
        if(*offset >= bufferLength) {
            return;
        }
        uint32_t byteOffset = dns_increment_offset(offset);
        uint8_t byte = buffer[byteOffset];
        
        switch(state) {
            case SMStateLength: {
                if((byte & 0xC0) == 0xC0) {
                    [self resetBufferToSize:2];
                    self->buffer[self->bufferOffset++] = (byte << 2) & 0xFF;
                    self->state = SMStatePointer;
                } else if(byte == 0x00) {
                    [self compileNameAndReset];
                    return;
                } else {
                    [self resetBufferToSize:byte];
                    self->state = SMStateData;
                }
                break;
            }
            case SMStatePointer: {
                self->buffer[self->bufferOffset++] = byte;
                uint32_t subOffset = dns_uint16_from_bytes(self->buffer);
                DNSLabelDecoder *subParser = [[DNSLabelDecoder alloc] init];
                [subParser decodeLabelInBuffer:buffer withOffset:&subOffset andLength:bufferLength];
                if(subParser.name != nil) {
                    [self->labels addObject:subParser.name];
                }
                [self compileNameAndReset];
                return;
            }
            case SMStateData: {
                self->buffer[self->bufferOffset++] = byte;
                if(self->bufferOffset == self->bufferSize) {
                    NSString *label = [[NSString alloc] initWithBytes:self->buffer length:self->bufferSize encoding:NSASCIIStringEncoding];
                    [self->labels addObject:label];
                    self->buffer = NULL;
                    [self resetBufferToSize:0];
                    self->state = SMStateLength;
                }
                break;
            }
        }
    }
}

@end
