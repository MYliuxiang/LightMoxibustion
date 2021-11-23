//
//  UIScrollView+Gesture.m
//  BHGY
//
//  Created by liuxiang on 2020/7/22.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "UIScrollView+Gesture.h"

@implementation UIScrollView (Gesture)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")] && ![self isKindOfClass:UITableView.class]) {
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan) {
            return YES;
        }
    }
    
    return NO;
}
@end
