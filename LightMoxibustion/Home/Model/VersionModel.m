//
//  VersionPkg.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "VersionModel.h"

@implementation VersionModel
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        
        
        U8 *mbuf = (U8 *)data.bytes;
        
        U8 vBuf[5];
        vBuf[0] = mbuf[3];
        vBuf[1] = mbuf[4];
        vBuf[2] = mbuf[5];
        vBuf[3] = mbuf[6];
        vBuf[4] = mbuf[7];

        
        NSData *adata = [[NSData alloc] initWithBytes:vBuf length:5];
        NSString *result = [[NSString alloc] initWithData:adata encoding:NSUTF8StringEncoding];
        
        self.version = result;
    }
    return self;
}
@end
