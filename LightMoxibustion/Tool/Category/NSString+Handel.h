//
//  NSString+Handel.h
//  BHGY
//
//  Created by liuxiang on 2020/7/20.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Handel)

//获取文字长度
- (CGFloat)getWidthWithfont:(UIFont *)font;
//获取文字高度没有有行高
- (CGFloat)getHeightWithfont:(UIFont *)font viewWidth:(CGFloat)width;
//获取文字高度有行高
- (CGFloat)getHeightWithlineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
