//
//  YTSliderSetting.h
//  YTSliderView
//
//  Created by yitezh on 2019/10/19.
//  Copyright © 2019 yitezh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YTSliderLayoutDirection) {
   YTSliderLayoutDirectionHorizontal  = 0,
   YTSliderLayoutDirectionVertical,
};


@interface YTSliderSetting : NSObject
//（默认）配置
+ (instancetype)defaultSetting ;
//垂直配置
+ (instancetype)verticalSetting;

//内边距
@property (assign, nonatomic)int  progressInset;
//滑动过程是否展示进度
@property (assign, nonatomic)BOOL shouldShowProgress;
//布局方式（垂直或水平）
@property (assign, nonatomic)YTSliderLayoutDirection  layoutDirection;
//背景色
@property (strong, nonatomic) UIColor *backgroundColor;
//进度条颜色
@property (strong, nonatomic) UIColor *progressColor;
//小球颜色
@property (strong, nonatomic) UIColor *thumbColor;

//小球标题
@property (copy, nonatomic) NSString *thumbTitle;

//步数
@property (assign, nonatomic) NSInteger step;


//小球边框颜色
@property (strong, nonatomic) UIColor *thumbBorderColor;
//边线宽度
@property (assign, nonatomic)CGFloat borderWidth;


@end

NS_ASSUME_NONNULL_END
