//
//  PPSliderDemoView.m
//  PPColorfulSlider
//
//  Created by 拍拍 on 2019/12/9.
//  Copyright © 2019 PaiPai Lian. All rights reserved.
//

#import "LxUnitSlider.h"

#import "Masonry.h"
#import "YTSliderView.h"
#import "YTSliderSetting.h"

@interface LxUnitSlider()<YTSliderViewDelegate>
//slider相关
@property (nonatomic, strong) YTSliderView *slider;                     //滑块
@property (nonatomic, strong) UIColor *startColor;                          //滑块渐变色，起始
@property (nonatomic, strong) UIColor *endColor;                            //滑块渐变色，结束
@property (nonatomic, strong) UIButton *sliderUpBtn;                      //滑块左按钮
@property (nonatomic, strong) UIButton *sliderDownBtn;                     //滑块右按钮
@property (nonatomic, strong) NSTimer *leftBtnTimer;
@property (nonatomic, strong) NSTimer *rightBtnTimer;

@property (nonatomic, assign) NSInteger minNumber;                          //导轨最低值
@property (nonatomic, assign) NSInteger maxNumber;                          //导轨最大值
@property (nonatomic, assign) NSInteger minCouldSliderNumber;               //滑块可滑最低值
@property (nonatomic, assign) NSInteger maxCouldSliderNumber;               //滑块可滑最大值
@property (nonatomic, assign) NSInteger minSliderUnit;                      //最小单位
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,assign) float totalValue;
@property(nonatomic,copy) NSString *thumbTitle;


@end



@implementation LxUnitSlider


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles total:(float)totalValue thumbTitle:(NSString *)thumbTitle{
    if (self = [super initWithFrame:frame]) {
        _minNumber = 0;
        _maxNumber = totalValue;
        
        _minCouldSliderNumber = 0;
        _maxCouldSliderNumber = totalValue;
        _minSliderUnit = 1;
        
        
//        _startColor = PPCOLOR(0xFFDA9B);
//        _endColor = PPCOLOR(0xFFAB3D);
        _titles = titles;
        _totalValue = totalValue;
        _thumbTitle = thumbTitle;
        
        [self initSubView];
    }
    return self;
}

- (void)creatTitles{
    
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.titles[i];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:8 * WidthScale];
        label.left = self.slider.right + 10 * WidthScale;
        [label sizeToFit];
        if (i == 0) {
            label.bottom = self.slider.height + 57 * WidthScale - (self.slider.height / (self.titles.count - 1)) * i;
        }else if (i == self.titles.count - 1){
            label.top = self.slider.height + 57 * WidthScale - (self.slider.height / (self.titles.count - 1)) * i;

        }else{
            label.centerY = self.slider.height + 57 * WidthScale - (self.slider.height / (self.titles.count - 1)) * i;
        }
        [self addSubview:label];
    }
    
}

- (void)creatButtom{
    _sliderDownBtn = [[UIButton alloc]init];
    [_sliderDownBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_sliderDownBtn setImage:[UIImage imageNamed:@"proc_btn_dec"] forState:UIControlStateNormal];
    [_sliderDownBtn setImage:[UIImage imageNamed:@"proc_btn_dec_press"] forState:UIControlStateHighlighted];


    [_sliderDownBtn addTarget:self action:@selector(clickMinBtn) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_sliderDownBtn];
    [_sliderDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(37 * WidthScale, 37 * WidthScale));
        make.bottom.mas_equalTo(self);
    }];
    _sliderUpBtn = [[UIButton alloc]init];
    [_sliderUpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_sliderUpBtn setImage:[UIImage imageNamed:@"proc_btn_inc"] forState:UIControlStateNormal];
    [_sliderUpBtn setImage:[UIImage imageNamed:@"proc_btn_inc_press"] forState:UIControlStateHighlighted];
    if (_maxNumber == _minCouldSliderNumber) {
        [_sliderUpBtn setImage:[UIImage imageNamed:@"slider_plus_Unablebtn"] forState:UIControlStateNormal];
        [_sliderUpBtn setImage:[UIImage imageNamed:@"slider_plus_Unablebtn"] forState:UIControlStateHighlighted];
    }
  
    [_sliderUpBtn addTarget:self action:@selector(clickPlusBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sliderUpBtn];
    [_sliderUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(37 * WidthScale, 37 * WidthScale));
        make.top.mas_equalTo(self);
    }];
}

- (void)initSubView{

    [self creatButtom];

    
    YTSliderSetting *setting = [[YTSliderSetting alloc] init];
    setting.borderWidth = 0;
    setting.progressInset = 0;
    setting.layoutDirection = YTSliderLayoutDirectionVertical;
    setting.backgroundColor = [UIColor colorWithHexString:@"#E6E9EA"];
    setting.progressColor = [UIColor clearColor];
    setting.thumbColor = [UIColor clearColor];

    setting.shouldShowProgress = YES;
    setting.thumbTitle = self.thumbTitle;
    setting.step = self.titles.count > 2 ? self.titles.count - 2 : 0;
    _slider = [[YTSliderView alloc]initWithFrame:CGRectMake((100 - 30) / 2, 57 * WidthScale, 24 * WidthScale, self.height - (57 * WidthScale * 2)) setting: setting];
    _slider.delegate = self;
    _slider.centerX = self.width / 2.0;
    _slider.delegate = self;
    [self addSubview:_slider];
    
    [self creatTitles];

  
}

- (void)setCurrentPercent:(NSInteger)currentPercent
{
    if (currentPercent > _maxNumber) {
        return;
    }
    _currentPercent = currentPercent;
    _slider.currentPercent = _currentPercent / _totalValue;
    
}

#pragma mark ---------- YTSliderViewDelegate

- (void)ytSliderView:(YTSliderView *)view didChangePercent:(CGFloat)percent{
//    _currentPercent = roundf(percent * _totalValue);
    
    if ([self.delegate respondsToSelector:@selector(unitSliderView:didChangePercent:)] && [self.thumbTitle isEqualToString:@"温度"]) {
        NSInteger tem = roundf(_slider.currentPercent * _totalValue) + 29;
        [self.delegate unitSliderView:self didChangePercent:tem];
    }
        
}

- (void)ytSliderViewDidBeginDrag:(YTSliderView *)view{
}

- (void)ytSliderViewDidEndDrag:(YTSliderView *)view{
    
    [self bluePercent:roundf(view.currentPercent * _totalValue)];
//    view.currentPercent = self.currentPercent / _totalValue;


}

#pragma mark - 点击积分增加按钮

- (void)clickPlusBtn{

    if ([self.thumbTitle isEqualToString:@"温度"] && roundf(_slider.currentPercent * _totalValue) + _minSliderUnit > 16) {
        
        float tem = roundf(_slider.currentPercent * _totalValue + _minSliderUnit);
        if (tem + 29 > 51) {
            return;
        }
        [self bluePercent:tem];
                
    }else{
        if (_slider.currentPercent * _totalValue >= _maxCouldSliderNumber) {
            return;
        }else if(_slider.currentPercent * _totalValue + _minSliderUnit >= _maxCouldSliderNumber){
            _slider.currentPercent = _maxCouldSliderNumber / _totalValue;
        }else{
            _slider.currentPercent = (_slider.currentPercent * _totalValue + _minSliderUnit) / _totalValue;
        }
        
        [self bluePercent:roundf(_slider.currentPercent * _totalValue)];
    }

}

- (void)bluePercent:(NSInteger)percent{
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    if (manger.connectedPerpheral == nil) {
        self.currentPercent = 0;
        return;
    }
    if ([self.thumbTitle isEqualToString:@"温度"]) {
        
        int tem = (int)(percent + 29);
        if (self.hightTemTipBlock) {
            self.hightTemTipBlock(tem);
        }
    }else if ([self.thumbTitle isEqualToString:@"频率"]){
        [SendData setRate:(int)percent];
    }else{
        [SendData setLaser:(int)percent];
    }
}

#pragma mark - 点击积分减少按钮
- (void)clickMinBtn{
      
    if ([self.thumbTitle isEqualToString:@"温度"] && roundf(_slider.currentPercent * _totalValue) - _minSliderUnit > 16) {
        [self bluePercent:roundf(_slider.currentPercent * _totalValue - _minSliderUnit)];
    }else{
        if (_slider.currentPercent * _totalValue <= 0 ) {
            return;
        }else if(_slider.currentPercent * _totalValue - _minSliderUnit <= 0){
            _slider.currentPercent = 0;
        }else{
            _slider.currentPercent = (_slider.currentPercent * _totalValue - _minSliderUnit) / _totalValue;
        }
        
        [self bluePercent:roundf(_slider.currentPercent * _totalValue)];
    }
       
}



#pragma mark - 处理渐变色圆角滑轨
- (UIImage *)getGradientImageWithColors:(NSArray*)colors imgSize:(CGSize)imgSize{
    NSMutableArray *arRef = [NSMutableArray array];
    for(UIColor *ref in colors) {
        [arRef addObject:(id)ref.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arRef, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(imgSize.width, imgSize.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage*)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image{
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    // 根据radius的值画出路线
    CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(radius, radius)].CGPath);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [image drawInRect:rect];
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

////这个方法转换出来的图片  文字图片会变模糊
//- (UIImage *)convertViewToImage:(UIView *)view {
//
//   UIGraphicsBeginImageContext(view.bounds.size);
//   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//   UIGraphicsEndImageContext();
//   return image;
//
//}


//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}

@end
