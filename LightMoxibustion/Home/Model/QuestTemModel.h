//
//  QuestTemPkg.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 获取仪器当前的设置时间：此指令用来返回仪器当前的设置工作时间，指令码为20.返回的时间值单位为秒。
 */
@interface QuestTemModel : NSObject
@property(nonatomic, strong) NSData *buf;

@end

NS_ASSUME_NONNULL_END
