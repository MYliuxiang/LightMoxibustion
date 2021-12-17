//
//  LxView.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/17.
//

#import "LxView.h"

@implementation LxView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}

@end
