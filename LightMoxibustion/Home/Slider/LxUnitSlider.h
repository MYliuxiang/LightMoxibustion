//
//  PPSliderDemoView.h
//  PPColorfulSlider
//
//  Created by 拍拍 on 2019/12/9.
//  Copyright © 2019 PaiPai Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxUnitSlider : UIView

@property (assign, nonatomic) NSInteger currentPercent;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles total:(float)totalValue thumbTitle:(NSString *)thumbTitle;
@end

