//
//  UIView+Corners.h
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corners)
//部分圆角
- (void)setupRoundedCorners:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius;

//部分圆角加描边
- (void)setupRoundedCorners:(UIRectCorner)rectCorner borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth viewColor:(UIColor *)viewColor;

@end

NS_ASSUME_NONNULL_END
