# DNS
> Objective-C DNS parsing library

**DNS** provides methods to decode and encode DNS messages

## Installing
Using [Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application), add the
following line to your `Cartfile`:
```
github "victorgama/dns"
```

> **Note**: This library requires [ip](https://github.com/victorgama/ip) as a
> dependency. Any application including this must also include ip.

## Usage

In order to decode DNS messages, the library expects fully assembled buffers to
be provided to decoding methods. This way, the library does not need to know
whether data was received through TCP or UDP, as the former must include extra
information indicating the message length. After receiving and assembling a
buffer including the message byte sequence, the following method may be used
to decode the message into objects:

```objc
#import <DNS/DNS.h>

uint32_t length;
uint8_t *bytes = receive_message_from_udp(&length);

DNSMessageDecoder *decoder = [[DNSMessageDecoder alloc] init];
[decoder decodeMessageInBuffer:bytes withLength:length];

// decoder.message will now include the deserialized message

```

After processing the message, the application can edit it and reencode it as
an answer:

```objc
DNSMessage *message = decoder.message;
message.header.isQuery = NO;
message.header.responseCode = DNSRCodeNonExistentDomain;
NSData *encodedMessage = [DNSMessageEncoder encode:message];
```

## License

```
The MIT License (MIT)

Copyright (c) 2018 Victor Gama

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

```
