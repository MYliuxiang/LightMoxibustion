//
//  UISwitch+Custom.m
//  BHGY
//
//  Created by liuxiang on 2020/7/14.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "UISwitch+Custom.h"
#import "SwizzlingDefine.h"

@implementation UISwitch (Custom)
+ (void)load{
    static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           
           swizzling_exchangeMethod([UISwitch class], @selector(initWithCoder:), @selector(swizzling_initWithCoder:));
           swizzling_exchangeMethod([UISwitch class], @selector(init), @selector(swizzling_init));
           
       });
}

- (instancetype)swizzling_init
{
    id instance = [self swizzling_init];
    if (instance) {
//
        self.transform=CGAffineTransformMakeScale(0.8,0.8);
//        self.layer.anchorPoint=CGPointMake(0.5,0.5);

       
    }
    return instance;
    
}

- (instancetype)swizzling_initWithCoder:(NSCoder *)aDecoder
{
    id instance = [self swizzling_initWithCoder:aDecoder];
    if (instance) {
        //
        self.transform=CGAffineTransformMakeScale(0.8,0.8);
//        self.layer.anchorPoint=CGPointMake(0.7,0.5);
    }
    return instance;
}



@end
