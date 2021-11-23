//
//  RealTimePowerPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 实时温度返回：这个数据包由仪器自动返回，无需手机发送指令。返回的温度值需除以
    10后才是温度整数值。
 */
@interface RealTimeTem : NSObject
@property(nonatomic, strong) NSData *buf;


@end

NS_ASSUME_NONNULL_END
