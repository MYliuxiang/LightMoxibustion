//
//  UIColor+Extension.h
//  CustomSlider
//
//  Created by mac on 2021/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)
+ (UIColor *)colorWithHexString:(NSString *)color;
- (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
