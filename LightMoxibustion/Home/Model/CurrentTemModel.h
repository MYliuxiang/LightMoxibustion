//
//  CurrentTemPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 获取仪器当前的设置温度：此命令用来获取仪器当前的设置温度。命令码为数值13. 获得的温度值需除以10 才是整数部分。
 */
@interface CurrentTemModel : NSObject
@property(nonatomic, assign) int currentTem;
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
