//
//  ChargeStatePkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "ChargeStateModel.h"

@implementation ChargeStateModel
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        U8 *mbuf = (U8 *)data.bytes;
        self.CHG = mbuf[3];
        self.STANDBY = mbuf[4];

    }
    return self;
}
@end
