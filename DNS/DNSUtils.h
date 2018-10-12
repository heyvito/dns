//
//  DNSUtils.h
//  DNS
//
//  Created by Victor Gama on 11/10/2018.
//  Copyright © 2018 Victor Gama. All rights reserved.
//

#ifndef DNSUtils_h
#define DNSUtils_h

NS_INLINE uint16_t dns_uint16_from_bytes(uint8_t *bytes) {
    return (bytes[0] << 8) | bytes[1];
}

NS_INLINE uint16_t dns_take_bits(uint16_t from, uint8_t offset, uint8_t length) {
    uint8_t size = 15 - (offset + length - 1);
    from = from >> size;
    return from & ~(0xffff << length);
}

NS_INLINE uint32_t dns_uint32_from_bytes(uint8_t *bytes) {
    return (bytes[0] << 24) |
    (bytes[1] << 16) |
    (bytes[2] << 8) |
    bytes[3];
}

NS_INLINE uint32_t dns_increment_offset(uint32_t *offset) {
    uint32_t retVal = *offset;
    *offset = retVal + 1;
    return retVal;
}

NS_INLINE void dns_write_uint16_into(uint8_t *buffer, uint32_t *offset, uint16_t val) {
    buffer[*offset] = (val >> 8) & 0xFF;
    *offset = *offset + 1;
    buffer[*offset] = val & 0xFF;
    *offset = *offset + 1;
}

NS_INLINE void dns_write_uint32_into(uint8_t *buffer, uint32_t *offset, uint32_t val) {
    buffer[*offset] = (val >> 24) & 0xFF;
    *offset = *offset + 1;
    buffer[*offset] = (val >> 16) & 0xFF;
    *offset = *offset + 1;
    buffer[*offset] = (val >> 8) & 0xFF;
    *offset = *offset + 1;
    buffer[*offset] = val & 0xFF;
    *offset = *offset + 1;
}

#endif /* DNSUtils_h */
