//
//  LxResfreshHeader.m
//  XiangYin
//
//  Created by liuxiang on 2018/12/20.
//  Copyright © 2018年 liuxiang. All rights reserved.
//

#import "LxResfreshHeader.h"

@implementation LxResfreshHeader


- (void)prepare
{
    [super prepare];
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#858296"];
    self.lastUpdatedTimeLabel.hidden = YES;
   
}

- (void)placeSubviews{
    [super placeSubviews];
//    self.stateLabel.bottom = self.mj_h;
//    self.stateLabel.centerY = self.mj_h - 20;
//    self.loadingView.bottom = self.mj_h;
//    self.arrowView.bottom = self.mj_h;
}




@end
