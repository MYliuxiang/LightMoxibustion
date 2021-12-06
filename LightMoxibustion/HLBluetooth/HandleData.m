//
//  HandleData.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

#import "HandleData.h"

@implementation HandleData
+ (int)verificationData:(NSData *)data{
    if (data.length < 20) {
        return 0;
    }
    U8 *mbuf = (U8 *)data.bytes;
    if (mbuf[0] != '5' || mbuf[1] != '#') {
        return 0;
    }
    
    
    int crc16 = CRC16_CCITT(mbuf, data.length - 2);
//    if (mbuf[data.length-2] != (Byte)(crc16>>8 & 0XFF) || mbuf[data.length-1] != (Byte)(crc16 & 0XFF)) {
//        return 0;
//    }
    
    
    
    return mbuf[2];

}
@end
