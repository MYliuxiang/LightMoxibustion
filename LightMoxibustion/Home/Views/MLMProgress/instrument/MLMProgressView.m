//
//  MLMProgressView.m
//  MLMProgressView
//
//  Created by my on 16/8/4.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "MLMProgressView.h"
#import "TimeView.h"
#define GLRGBA(R, G, B, A) [UIColor colorWithRed:(R)/255.f green:(G)/255.f blue:(B)/255.f alpha:(A)]

@interface MLMProgressView ()
@property(nonatomic,strong) UIButton *leftB;
@property(nonatomic,strong) UIButton *rightB;
@property(nonatomic,strong) NumberView *setTemV;
@property(nonatomic,strong) NumberView *currentTemV;
@property(nonatomic,strong) UIImageView *symbolI1;
@property(nonatomic,strong) UIImageView *symbolI2;

@property(nonatomic,strong) TimeView *timeV;

@property(nonatomic,strong) UIImageView *tipI;



@end

@implementation MLMProgressView


//速度表盘
- (UIView *)speedDialType {
    CGFloat startAngle = 180;
    CGFloat endAngle = 360;
    //刻度
    _calibra = [[MLMCalibrationView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) startAngle:startAngle endAngle:endAngle];
    _calibra.textType = MLMCalibrationViewTextDefault;
    _calibra.maxValue = 20;
    _calibra.smallScaleNum = 5;
    _calibra.majorScaleNum = 4;
    _calibra.majorScaleLength = 10 * WidthScale;
    _calibra.majorScaleWidth = 4 * WidthScale;
    _calibra.smallScaleLength = 5 * WidthScale;
    _calibra.smallScaleWidth = 2 * WidthScale;
    _calibra.edgeSpace = 0;
    _calibra.scaleSpace = 16 * WidthScale;
    _calibra.scaleFont = [UIFont systemFontOfSize:12 * WidthScale];
    _calibra.bgColor = [UIColor colorWithWhite:1 alpha:.3];
    [_calibra drawCalibration];
    [self addSubview:_calibra];
    
//    //进度
    _circle = [[MLMCircleView alloc] initWithFrame:CGRectMake(- 15 * WidthScale, - 15 * WidthScale, _calibra.width + 30 * WidthScale, _calibra.height + 30 * WidthScale) startAngle:startAngle endAngle:endAngle];
    _circle.bottomWidth = 11 * WidthScale;
    _circle.progressWidth = 10 * WidthScale;
    _circle.fillColor = [UIColor colorWithHexString:@"2446A0"];
    _circle.bgColor = [UIColor colorWithHexString:@"D8DDFC"];
    _circle.dotDiameter = 0;
    _circle.capRound = NO;
    _circle.progressSpace = -10 * WidthScale;
    [_circle bottomNearProgress:YES];
    [_circle drawProgress];
    [self addSubview:_circle];
    
    _incircle = [[MLMCircleView alloc] initWithFrame:CGRectMake(- 4 * WidthScale,- 4 * WidthScale, _calibra.width + 8 * WidthScale,  _calibra.width + 8 * WidthScale) startAngle:startAngle endAngle:endAngle];
    _incircle.bottomWidth = 0;
    _incircle.progressWidth = 44 * WidthScale;
    _incircle.fillColor = [UIColor colorWithWhite:1 alpha:.3];
    _incircle.bgColor = [UIColor yellowColor];
    _incircle.dotDiameter = 25 * WidthScale;
    _incircle.isTransparent = YES;
    _incircle.capRound = NO;
    _incircle.dotImage = [UIImage imageNamed:@"time_set_thumb"];

    [_incircle bottomNearProgress:YES];
    [self addSubview:_incircle];
    
    
    
    //中间
    
    UIView *centerV = [[UIView alloc] init];
    centerV.frame = CGRectMake(44 * WidthScale, 44 * WidthScale, _incircle.width - 89 * WidthScale, _incircle.width -89 * WidthScale);
    centerV.layer.cornerRadius = (_incircle.width - 89 * WidthScale)/ 2.0;
    centerV.layer.masksToBounds = YES;
    centerV.backgroundColor = [UIColor colorWithHexString:@"D8DDFC"];
    [_incircle addSubview:centerV];
    
    
    _timeV = [[TimeView alloc] initWithFrame:CGRectMake(0, 0, 100 * WidthScale, 35 * WidthScale)];
    _timeV.top = centerV.height / 2.0 ;
    _timeV.centerX = centerV.width / 2.0;
    [centerV addSubview:_timeV];
        
    UIImageView *timeNameI = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 90 * WidthScale, 22 * WidthScale)];
    timeNameI.image = [UIImage imageNamed:@"text_zhi_liao_shi_jian"];
    timeNameI.bottom = centerV.height / 2.0 - 20 * WidthScale;
    timeNameI.centerX = centerV.width / 2.0;
    [centerV addSubview:timeNameI];
    
    
    
    
    _leftB = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftB.frame = CGRectMake(- 12 * WidthScale, _incircle.height / 2.0 + 25 * WidthScale, 67 * WidthScale, 67 * WidthScale);
    [_leftB setImage:[UIImage imageNamed:@"arc_time_btn_dec"] forState:UIControlStateNormal];
    [_leftB setImage:[UIImage imageNamed:@"arc_time_btn_dec_press"] forState:UIControlStateHighlighted];

    [_leftB addTarget:self action:@selector(leftBAC:) forControlEvents:UIControlEventTouchUpInside];
    [_incircle addSubview:_leftB];
    
   
    _rightB = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightB.frame = CGRectMake(_incircle.width + 12 * WidthScale - 67 * WidthScale, _incircle.height / 2.0 + 25 * WidthScale, 67 * WidthScale, 67 * WidthScale);
    [_rightB setImage:[UIImage imageNamed:@"arc_time_btn_inc"] forState:UIControlStateNormal];
    [_rightB setImage:[UIImage imageNamed:@"arc_time_btn_inc_press"] forState:UIControlStateHighlighted];

    [_rightB addTarget:self action:@selector(rightBAC:) forControlEvents:UIControlEventTouchUpInside];
    [_incircle addSubview:_rightB];
    
    _setTemV = [[NumberView alloc] initWithFrame:CGRectMake((centerV.width - 30 * WidthScale) / 2 - 10 * WidthScale, centerV.bottom + 10 * WidthScale, 30 * WidthScale, 27 * WidthScale) withTemType:TemperatureTypeSet];
    [_incircle addSubview:_setTemV];
    
    _currentTemV = [[NumberView alloc] initWithFrame:CGRectMake(centerV.width / 2.0 + (centerV.width - 30 * WidthScale) / 2.0  + 10 * WidthScale, centerV.bottom + 10 * WidthScale, 30 * WidthScale, 27 * WidthScale) withTemType:TemperatureTypeCurrent];
    [_incircle addSubview:_currentTemV];
    
    _symbolI1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18 * WidthScale, 14 * WidthScale)];
    _symbolI1.image = [UIImage imageNamed:@"temp_unit_symbo2"];
    _symbolI1.top = _setTemV.top;
    _symbolI1.left = _setTemV.right + 2;
    [_incircle addSubview:_symbolI1];
    
    _symbolI2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18 * WidthScale, 14 * WidthScale)];
    _symbolI2.image = [[UIImage imageNamed:@"temp_unit_symbo2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _symbolI2.tintColor = [UIColor redColor];

    _symbolI2.top = _currentTemV.top;
    _symbolI2.left = _currentTemV.right + 2;
    [_incircle addSubview:_symbolI2];
    
    
    UIImageView *chacterI1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55 * WidthScale, 15 * WidthScale)];
    chacterI1.image = [UIImage imageNamed:@"text_set_temp"];
    chacterI1.top = _setTemV.bottom + 10 * WidthScale;
    chacterI1.centerX = _setTemV.centerX;
    [_incircle addSubview:chacterI1];
    
    UIImageView *chacterI2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55 * WidthScale, 15 * WidthScale)];
    chacterI2.image = [UIImage imageNamed:@"text_cure_temp"];
    chacterI2.top = _currentTemV.bottom + 10 * WidthScale;
    chacterI2.centerX = _currentTemV.centerX;
    [_incircle addSubview:chacterI2];
    
    
    self.tipI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waring_dilog_out_temp"]];
    self.tipI.size = CGSizeMake(80 * 2.5 * WidthScale, 54 * 2.5 * WidthScale);
    self.tipI.left = _leftB.centerX - 25 * WidthScale;
    self.tipI.top = _leftB.centerY + 5 * WidthScale;
//    self.tipI.hidden = YES;
    [_incircle addSubview:self.tipI];
    
    
    
    
  
    return self;
}

- (void)leftBAC:(UIButton *)sender{
    
}

- (void)rightBAC:(UIButton *)sender{
    
}


@end
