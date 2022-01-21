//
//  HandleData.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

/*
 蓝牙数据解析类
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HandleData : NSObject

+ (int)verificationData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
