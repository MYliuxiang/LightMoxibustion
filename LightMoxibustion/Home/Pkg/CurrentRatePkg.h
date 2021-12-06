//
//  CurrentRatePkg.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 获取当前灯光闪动频率档位：此命令用来获取仪器当前的灯光闪动频率档位，命令码为数值12。
 */
@interface CurrentRatePkg : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
