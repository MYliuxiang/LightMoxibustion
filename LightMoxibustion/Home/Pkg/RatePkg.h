//
//  RatePkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 设定频率：此命令用来设定仪器的灯闪频率档位。命令码为数值4，参数为一字节
 */
@interface RatePkg : NSObject
@property(nonatomic, strong) NSData *buf;

- (instancetype)initWithRate:(int)rate;

@end

NS_ASSUME_NONNULL_END
