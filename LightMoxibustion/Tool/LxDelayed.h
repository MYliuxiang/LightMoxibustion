//
//  LxDelayed.h
//  BiDui
//
//  Created by 刘翔 on 2018/5/8.
//  Copyright © 2018年 刘翔. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^BackTimeBlock) ();

@interface LxDelayed : NSObject

+ (void)delayedTime:(double)time withActionBlock:(BackTimeBlock)actionBlock;

@end
