//
//  IntToByte.m
//  QL_TCPTest
//
//  Created by Qiulong-CQ on 16/11/3.
//  Copyright © 2016年 xiaoheng. All rights reserved.
//

#import "IntToByte.h"

@implementation IntToByte

//http://www.jianshu.com/p/d1c9477442f6

//此代码是低位在前  高位在后，

//如果是低位在后 那就把index掉头处理，

//这是4字节byte的处理，如果是其他字节，灵活变动下
- (void)IntToByte:(int)a;
{
    
    
    
    Byte byte[2] = {};
    
//    byte[0] =  (Byte) ((a>>24) & 0xFF);
//
//    byte[1] =  (Byte) ((a>>16) & 0xFF);
    
    byte[0] =  (Byte) ((a>>8) & 0xFF);

    byte[1] =  (Byte) (a & 0xFF);
    
    //打印出来的byte[0]，byte[1]....是十进制数    不要认为是十六进制。
//    300
    NSLog(@"byte[0] = %x",byte[0]);
    NSLog(@"byte[1] = %x",byte[1]);
//    NSLog(@"byte[2] = %d",byte[2]);
//    NSLog(@"byte[3] = %d",byte[3]);
    
//    4 * 16 + 4 =
    
    
}

@end
