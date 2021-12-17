//
//  MLMCircleView.h
//  MLMProgressView
//
//  Created by my on 16/8/4.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLMProgressHeader.h"
@class MLMCircleView;

@protocol MLMCircleViewDelegate <NSObject>

@optional

- (void)mLMCircleView:(MLMCircleView *)view didChangePercent:(CGFloat)percent;

- (void)mLMCircleViewDidBeginDrag:(MLMCircleView *)view;

- (void)mLMCircleViewDidEndDrag:(MLMCircleView *)view;
@end

@interface MLMCircleView : UIView

///弧度背景色
@property (nonatomic, strong) UIColor *bgColor;
///弧度填充色
@property (nonatomic, strong) UIColor *fillColor;
///弧度渐变色
@property (nonatomic, strong) UIColor *gradualColor;


///弧度线宽
@property (nonatomic, assign) CGFloat bottomWidth;
@property (nonatomic, assign) CGFloat progressWidth;

///光标的背景图片
@property (nonatomic, strong) UIImage *dotImage;

///光标直径
@property (nonatomic, assign) CGFloat dotDiameter;

///边缘间隔
@property (nonatomic, assign) CGFloat edgespace;

///bottom和progress间隔,相对于bottom
@property (nonatomic, assign) CGFloat progressSpace;

///freeWidth
@property (nonatomic, assign, readonly) CGFloat freeWidth;

///是否圆角,默认YES
@property (nonatomic, assign) BOOL capRound;

@property (nonatomic, assign) BOOL isTransparent;

@property (nonatomic, weak) id<MLMCircleViewDelegate> delegate;

@property (nonatomic, assign) CGFloat progress;





@property (nonatomic, strong) UIImageView *dotImageView;//光标
@property (nonatomic, strong) CAShapeLayer *bottomLayer;//弧度背景
@property (nonatomic, strong) CAShapeLayer *progressLayer;//进度
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


- (instancetype)initWithFrame:(CGRect)frame
                   startAngle:(CGFloat)start
                     endAngle:(CGFloat)end;


///图片隐藏
- (void)dotHidden:(BOOL)hidden;

///内外线紧邻(默认是覆盖),YES外接
- (void)bottomNearProgress:(BOOL)outOrIn;

///请务必使用绘制
- (void)drawProgress;



@end
