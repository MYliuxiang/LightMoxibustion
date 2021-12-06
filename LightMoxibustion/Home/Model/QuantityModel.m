//
//  QuantityPkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "QuantityModel.h"

@implementation QuantityModel

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        U8 *mbuf = (U8 *)data.bytes;
        self.quantity = (mbuf[3] & 0xFF);
    }
    return self;
}

@end
