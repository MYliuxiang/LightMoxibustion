//
//  CurrentTemPkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "CurrentTemModel.h"

@implementation CurrentTemModel

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        U8 *mbuf = (U8 *)data.bytes;
        self.currentTem = ((mbuf[3] & 0xFF) + ((mbuf[4] & 0xFF) << 8))/ 10;
    }
    return self;
}
@end
