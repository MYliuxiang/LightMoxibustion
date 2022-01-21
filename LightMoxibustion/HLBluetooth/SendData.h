//
//  SendData.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

/*
 数据发送工具
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendData : NSObject




+ (void)sendHeartBeat;

/*
 设置温度：此命令用来设定仪器工作时想要到达的温度，命令码为数值3，命令参数为俩字节，要设定的温度值需乘10后再分拆成高低字节进行填充。如设定为30度时，30X10
 =300，再把300拆开成高低俩个字节进行填充。温度范围30 - 51。另外，发送0值温度用来关闭灯光，停止工作。
 */
+ (void)setTemperature:(int)temperature;

/*
 设定频率：此命令用来设定仪器的灯闪频率档位。命令码为数值4，参数为一字节
 */
+ (void)setRate:(int)rate;

/*
 设置激光档位：此命令用来设定仪器的激光档位。命令码为数值6，参数为一字节
 */
+ (void)setLaser:(int)laser;

/*
 更新电量显示：仪器的电量分0到3格指示，分俩种方法获取，一是手机主动发送指令
 码8去获取。另一种情况是当仪器电量发生变化时，会主动发回电量数据包。
 */
+ (void)updateQuantiy;

/*
 获取当前激光设置档位：此命令用来获取仪器当前的激光档位，命令码为数值11。返回的档位值为0时表示激光已关闭。
 */
+ (void)getCurrentLaser;

/*
 获取当前灯光闪动频率档位：此命令用来获取仪器当前的灯光闪动频率档位，命令码为数值12
 */
+ (void)getCurrentRate;

/*
 获取仪器当前的设置温度：此命令用来获取仪器当前的设置温度。命令码为数值13. 获得的温度值需除以10 才是整数部分。
 */
+ (void)getCurrentTem;

/*
 获取仪器的固件版本号：此指令用来获取仪器的固件版本，指令为数值15，固件版本号构成格式为“X.X.X”,X为0到9 的字符。
 */
+ (void)getVersion;

/*
 请求返回充电IC状态：手机发出此指令，可立即返回充电IC的状态。手机发出的命令码为17，设备返回数据命令码为16，组成和上一条指令一样。
 */
+ (void)getChargeState;

/*
 设置工作时间（弧形）：此指令用来把设置的工作时间发送到仪器。指令码为数值18.参数为一字节，填充时间值，单位为分钟
 */
+ (void)setCurrentWorkTime:(int)minute;

/*
 获取仪器当前的设置时间：此指令用来返回仪器当前的设置工作时间，指令码为20.返回的时间值单位为秒。
 */
+ (void)getCurrentSetTime;











@end

NS_ASSUME_NONNULL_END
