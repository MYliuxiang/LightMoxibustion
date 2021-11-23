//
//  LxDelayed.m
//  BiDui
//
//  Created by 刘翔 on 2018/5/8.
//  Copyright © 2018年 刘翔. All rights reserved.
//

#import "LxDelayed.h"

@implementation LxDelayed

+ (void)delayedTime:(double)time withActionBlock:(BackTimeBlock)actionBlock
{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        actionBlock();
    });
    
}
@end
