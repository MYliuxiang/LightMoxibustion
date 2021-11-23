//
//  UIView+Corners.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "UIView+Corners.h"

@implementation UIView (Corners)
- (void)setupRoundedCorners:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius{
    
    CAShapeLayer *mask=[CAShapeLayer layer];
    UIBezierPath * path= [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius,cornerRadius)];
     mask.path=path.CGPath;
     mask.frame=self.bounds;
    self.layer.mask = mask;



}

- (void)setupRoundedCorners:(UIRectCorner)rectCorner borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth viewColor:(UIColor *)viewColor{
    CAShapeLayer *mask=[CAShapeLayer layer];
      UIBezierPath * path= [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius,cornerRadius)];
      mask.path=path.CGPath;
      mask.frame=self.bounds;


      CAShapeLayer *borderLayer=[CAShapeLayer layer];
      borderLayer.path=path.CGPath;
      borderLayer.fillColor = [UIColor clearColor].CGColor;
      borderLayer.strokeColor = borderColor.CGColor;
      borderLayer.lineWidth = borderWidth;
      borderLayer.frame = self.bounds;
      self.layer.mask = mask;
      [self.layer addSublayer:borderLayer];
          
}

@end
