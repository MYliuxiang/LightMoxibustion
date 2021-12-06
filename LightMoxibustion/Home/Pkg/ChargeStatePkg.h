//
//  ChargeStatePkg.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 请求返回充电IC状态：手机发出此指令，可立即返回充电IC的状态。手机发出的命令码为17，设备返回数据命令码为16，组成和上一条指令一样。
 */
@interface ChargeStatePkg : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
