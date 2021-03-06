//
//  CurrentLaserPkg.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 获取当前激光设置档位：此命令用来获取仪器当前的激光档位，命令码为数值11。返回的档位值为0时表示激光已关闭。
 */
@interface CurrentLaserPkg : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
