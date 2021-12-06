//
//  GetWorkTimePkg.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 获取仪器当前的设置时间：此指令用来返回仪器当前的设置工作时间，指令码为20.返回的时间值单位为秒。
 */
@interface GetCurrentSetTimePkg : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
