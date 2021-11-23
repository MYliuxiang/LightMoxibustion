//
//  TemperaturePkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "TemperaturePkg.h"

@implementation TemperaturePkg
- (instancetype)initWithTemperature:(int)temperature{
    
    self = [super init];
    if (self) {
        U8 buf[COMMON_PKG_LENGTH];
        memset(buf, 0, COMMON_PKG_LENGTH);
        buf[0] = 0x05;
        buf[1] = '#';//包头
        buf[2] = (Byte)(3 & 0XFF); //命令码
                
        buf[3] =  (Byte) ((temperature * 10) & 0xFF);
        buf[4] =  (Byte) (((temperature * 10)>>8) & 0xFF);
        
        int crc16 = CRC16_CCITT(buf, COMMON_PKG_LENGTH-2);
        buf[COMMON_PKG_LENGTH-2] = (Byte)(crc16>>8 & 0XFF);
        buf[COMMON_PKG_LENGTH-1] = (Byte)(crc16 & 0XFF);

        _buf = [NSData dataWithBytes:buf length:COMMON_PKG_LENGTH];
        
//        U8 *mbuf = [_buf bytes];
//        NSLog(@"mbuf:%s",mbuf);
//        NSLog(@"buf:%s",buf);
//        int height = 0;
//        height = height + (mbuf[3] & 0xFF) ;
//        height = height + ((mbuf[4] & 0xFF) << 8);
//        NSLog(@"height:%d",height);

        
    }
    return self;
}

@end