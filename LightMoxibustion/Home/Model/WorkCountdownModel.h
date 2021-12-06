//
//  WorkCountdownPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 工作倒计时返回：这个数据包由仪器自动返回，指示仪器的工作倒计时。无需手机发送指令。返回的时间以秒为单位。
 */
@interface WorkCountdownModel : NSObject
@property(nonatomic, assign) int second;
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
