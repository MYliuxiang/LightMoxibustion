//
//  LaserPkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "LaserPkg.h"

@implementation LaserPkg
- (instancetype)initWithLaser:(int)laser{
    
    self = [super init];
    if (self) {
        U8 buf[COMMON_PKG_LENGTH];
        memset(buf, 0, COMMON_PKG_LENGTH);
        buf[0] = '5';
        buf[1] = '#';//包头
        buf[2] = (Byte)(6 & 0XFF); //命令码
        buf[3] =  (Byte) ((laser * 10) & 0xFF);

        int crc16 = CRC16_CCITT(buf, COMMON_PKG_LENGTH-2);
        buf[COMMON_PKG_LENGTH-2] = (Byte)(crc16>>8 & 0XFF);
        buf[COMMON_PKG_LENGTH-1] = (Byte)(crc16 & 0XFF);

        _buf = [NSData dataWithBytes:buf length:COMMON_PKG_LENGTH];
    }
    return self;
}
@end
