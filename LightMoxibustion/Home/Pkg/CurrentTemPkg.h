//
//  CurrentTemPkg.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 获取仪器当前的设置温度：此命令用来获取仪器当前的设置温度。命令码为数值13. 获得的温度值需除以10 才是整数部分。
 */
@interface CurrentTemPkg : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
