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

@property(nonatomic,strong) UIImageView *symbolI1;
@property(nonatomic,strong) UIImageView *symbolI2;

@property(nonatomic,strong) TimeView *timeV;

@property(nonatomic,strong) UIView *tipV;

@property(nonatomic,assign) int hightTem;

@property(nonatomic,strong) UIButton *cancleB;

@property(nonatomic,strong) UIButton *doneB;



@end

@implementation MLMProgressView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    CGPoint doneBPoint = [self.doneB convertPoint:point fromView:self];
    if ([self.doneB pointInside:doneBPoint withEvent:event]) {
        return self.doneB;
    }
    
    CGPoint cancleBPoint = [self.cancleB convertPoint:point fromView:self];
    if ([self.doneB pointInside:cancleBPoint withEvent:event]) {
        return self.cancleB;
    }
   
    return view;
}

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
    _symbolI1.hidden = YES;
    [_incircle addSubview:_symbolI1];
    
    _symbolI2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18 * WidthScale, 14 * WidthScale)];
    _symbolI2.image = [[UIImage imageNamed:@"temp_unit_symbo2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _symbolI2.tintColor = [UIColor redColor];

    _symbolI2.top = _currentTemV.top;
    _symbolI2.left = _currentTemV.right + 2;
    _symbolI2.hidden = YES;
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
    
    self.tipV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80 * 2.5 * WidthScale, 54 * 2.5 * WidthScale)];
    self.tipV.left = _leftB.centerX - 25 * WidthScale;
    self.tipV.top = _leftB.centerY + 5 * WidthScale;
    [_incircle addSubview:self.tipV];
    self.tipV.hidden = YES;

    
    UIImageView *tipI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waring_dilog_out_temp"]];
    tipI.size = CGSizeMake(80 * 2.5 * WidthScale, 54 * 2.5 * WidthScale);
    tipI.left = 0;
    tipI.top = 0;
    tipI.userInteractionEnabled = YES;
    [self.tipV addSubview:tipI];
    
    _cancleB = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleB.frame = CGRectMake(0, 54 * 2.5 * WidthScale - 30 * WidthScale, 30 * WidthScale, 14 * WidthScale);
    _cancleB.right = self.tipV.width / 2.0 - 20 * WidthScale;
    [_cancleB setImage:[UIImage imageNamed:@"btn_no_red_back"] forState:UIControlStateNormal];
    [_cancleB addTarget:self action:@selector(cancleAC:) forControlEvents:UIControlEventTouchUpInside];
    [self.tipV addSubview:_cancleB];
    
    _doneB = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneB.frame = CGRectMake(0, 54 * 2.5 * WidthScale - 30 * WidthScale, 30 * WidthScale, 14 * WidthScale);
    _doneB.left = self.tipV.width / 2.0 + 20 * WidthScale;
    [_doneB setImage:[UIImage imageNamed:@"btn_yes_red_back"] forState:UIControlStateNormal];
    [_doneB addTarget:self action:@selector(doneAC:) forControlEvents:UIControlEventTouchUpInside];
    _doneB.backgroundColor = [UIColor whiteColor];
    [self.tipV addSubview:_doneB];
    return self;
}

- (void)hightTemTip:(int)tem{
    self.hightTem = tem;
    [UIView animateWithDuration:0.35 animations:^{
        self.tipV.hidden = NO;
    }];
}

- (void)cancleAC:(UIButton *)sender{
    [UIView animateWithDuration:0.35 animations:^{
        self.tipV.hidden = YES;
    }];
    self.hightTem = 0;

}

- (void)doneAC:(UIButton *)sender{
    [UIView animateWithDuration:0.35 animations:^{
        self.tipV.hidden = YES;
    }];
    
    if ([HLBLEManager sharedInstance].connectedPerpheral != nil) {
        [SendData setTemperature:self.hightTem];
    }
    self.hightTem = 0;
}


- (void)leftBAC:(UIButton *)sender{
    
}

- (void)rightBAC:(UIButton *)sender{
    
}


- (void)configCurrentTem:(int)tem{
    if (tem == -1) {
        self.symbolI2.hidden = YES;

    }
    self.currentTemV.number = tem;
    self.symbolI2.hidden = NO;

}

- (void)configSetTem:(int)tem{
    
    if (tem < 30) {
        self.symbolI1.hidden = YES;
        self.setTemV.number = -1;
    }else{
        self.setTemV.number = tem;
        self.symbolI1.hidden = NO;
    }
   

}


@end
