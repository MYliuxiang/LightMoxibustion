//
//  QuantityPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 更新电量显示：仪器的电量分0到3格指示，分俩种方法获取，一是手机主动发送指令
 码8去获取。另一种情况是当仪器电量发生变化时，会主动发回电量数据包。
 */
@interface QuantityModel : NSObject
@property(nonatomic, assign) int quantity;
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
