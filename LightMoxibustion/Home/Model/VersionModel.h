//
//  VersionPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 获取仪器的固件版本号：此指令用来获取仪器的固件版本，指令为数值15，固件版本号构成格式为“X.X.X”,X为0到9 的字符。
 */
@interface VersionModel : NSObject
@property(nonatomic, copy) NSString *version;
- (instancetype)initWithData:(NSData *)data;


@end

NS_ASSUME_NONNULL_END
