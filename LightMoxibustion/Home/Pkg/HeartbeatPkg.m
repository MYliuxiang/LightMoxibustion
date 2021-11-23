//
//  HeartbeatPkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "HeartbeatPkg.h"

@implementation HeartbeatPkg
- (instancetype)init
{
    self = [super init];
    if (self) {
        U8 buf[COMMON_PKG_LENGTH];
        memset(buf, 0, COMMON_PKG_LENGTH);
        buf[0] = 0x05;
        buf[1] = '#';//包头
        buf[2] = (Byte)(14 & 0XFF); //命令码
        buf[3] = 'I';
        buf[4] = 'R';
        buf[5] = '-';
        buf[6] = 'H';
        buf[7] = 'e';
        buf[8] = 'a';
        buf[9] = 'r';
        buf[10] = 't';
        buf[11] = 'b';
        buf[12] = 'e';
        buf[13] = 'a';
        buf[14] = 't';


        int crc16 = CRC16_CCITT(buf, COMMON_PKG_LENGTH-2);
        buf[COMMON_PKG_LENGTH-2] = (Byte)(crc16>>8 & 0XFF);
        buf[COMMON_PKG_LENGTH-1] = (Byte)(crc16 & 0XFF);

        _buf = [NSData dataWithBytes:buf length:COMMON_PKG_LENGTH];
    }
    return self;
}
@end
