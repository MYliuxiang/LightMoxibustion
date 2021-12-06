//
//  CurrentSetTimeModel.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/5.
//

#import "CurrentSetTimeModel.h"

@implementation CurrentSetTimeModel
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        U8 *mbuf = (U8 *)data.bytes;
        self.second = ((mbuf[3] & 0xFF) + ((mbuf[4] & 0xFF) << 8)) / 10;
    }
    return self;
}
@end
