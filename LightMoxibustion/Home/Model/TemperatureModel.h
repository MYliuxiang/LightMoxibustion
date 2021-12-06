//
//  TemperatureModel.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 设置温度：此命令用来设定仪器工作时想要到达的温度，命令码为数值3，命令参数为俩字节，要设定的温度值需乘10后再分拆成高低字节进行填充。如设定为30度时，30X10
 =300，再把300拆开成高低俩个字节进行填充。温度范围30 - 51。另外，发送0值温度用来关闭灯光，停止工作。
 返回值
 */
@interface TemperatureModel : NSObject
@property(nonatomic, assign) int tem;
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
