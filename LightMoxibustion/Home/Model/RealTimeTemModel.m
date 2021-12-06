//
//  RealTimePowerPkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "RealTimeTemModel.h"

@implementation RealTimeTemModel
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        U8 *mbuf = (U8 *)data.bytes;
        self.tem = (mbuf[3] & 0xFF) + ((mbuf[4] & 0xFF) << 8);
    }
    return self;
}
@end
