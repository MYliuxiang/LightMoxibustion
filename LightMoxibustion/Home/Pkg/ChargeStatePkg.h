//
//  ChargeStatePkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 充电IC状态更新通知：此数据包由仪器主动返回，命令码为16，CHG和STANDBY信号各占一字节。当CHG为0 与SATANDBY 为1时表示正在充电，CHG为1与STANDBY为0表示充电完成。其它情况表示没有插入充电器。
 */
@interface ChargeStatePkg : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
