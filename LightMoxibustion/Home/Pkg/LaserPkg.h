//
//  LaserPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 设置激光档位：此命令用来设定仪器的激光档位。命令码为数值6，参数为一字节
 */
@interface LaserPkg : NSObject
@property(nonatomic, strong) NSData *buf;

- (instancetype)initWithLaser:(int)laser;

@end

NS_ASSUME_NONNULL_END
