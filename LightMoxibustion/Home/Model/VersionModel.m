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
        self.version = [NSString stringWithFormat:@"%d.%d.%d",mbuf[3],mbuf[5],mbuf[7]];
    }
    return self;
}
@end
