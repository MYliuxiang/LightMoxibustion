//
//  CurrentRatePkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 获取当前灯光闪动频率档位：此命令用来获取仪器当前的灯光闪动频率档位，命令码为数值12。
 */
@interface CurrentRateModel : NSObject
@property(nonatomic, assign) int rate;
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
