//
//  SetWorkTimePkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 设置工作时间（弧形）：此指令用来把设置的工作时间发送到仪器。指令码为数值18.参数为一字节，填充时间值，单位为分钟
 */
@interface SetWorkTimePkg : NSObject
@property(nonatomic, strong) NSData *buf;

- (instancetype)initWithMinute:(int)minute;

@end

NS_ASSUME_NONNULL_END
