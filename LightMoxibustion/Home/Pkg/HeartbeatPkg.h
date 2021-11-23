//
//  HeartbeatPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 心跳数据包：当手机连接上仪器后，需要每隔俩秒内向仪器发送一个心跳数据包，否则仪器会自动断开蓝牙。发送此数据包仪器不会有数据回应。心跳命令码为数值14，参数为字符串”IR-Heartbeat”,分别填充在第3到第14字节中。
 */
@interface HeartbeatPkg : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
