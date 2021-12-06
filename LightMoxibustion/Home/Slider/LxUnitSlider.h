//
//  PPSliderDemoView.h
//  PPColorfulSlider
//
//  Created by 拍拍 on 2019/12/9.
//  Copyright © 2019 PaiPai Lian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LxUnitSlider;
@protocol LxUnitSliderDelegate <NSObject>

@optional

- (void)unitSliderView:(LxUnitSlider *)slider didChangePercent:(NSInteger)percent;

@end


@interface LxUnitSlider : UIView

@property (assign, nonatomic) NSInteger currentPercent;
@property (weak, nonatomic) id<LxUnitSliderDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles total:(float)totalValue thumbTitle:(NSString *)thumbTitle;
@end

