//
//  MLMCircleView.m
//  MLMProgressView
//
//  Created by my on 16/8/4.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "MLMCircleView.h"

@interface MLMCircleView () {
    CGFloat circleRadius;//bottom半径
    CGFloat progressRadius;//进度半径
        
    ///起点
    CGFloat _startAngle;
    ///终点
    CGFloat _endAngle;
    
    CGFloat lastProgress;
}



@end


@implementation MLMCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame startAngle:150 endAngle:390];
}


- (instancetype)initWithFrame:(CGRect)frame
                   startAngle:(CGFloat)start
                     endAngle:(CGFloat)end {
    if (self = [super initWithFrame:frame]) {
        
        _startAngle = start;
        _endAngle = end;
        //默认数据
        [self initData];
        
        

    }
    return self;
}


#pragma mark - 默认数据
- (void)initData {
    _progressWidth = 6.f;
    _bottomWidth = 6.f;
    _bgColor = [UIColor blueColor];
    _fillColor = [UIColor redColor];
    _capRound = YES;
    _dotImage = [UIImage imageNamed:@"redDot"];
    _dotDiameter = 20.f;
    _edgespace = 0;
    _progressSpace = 0;

}


#pragma mark - 计算光标的起始center
- (void)dotCenter {
   
    if (_dotImageView) {
//        [_dotImageView removeFromSuperview];
    } else {
        _dotImageView = [[UIImageView alloc] init];
    }
    _dotImageView.frame = CGRectMake(0, 0, self.dotDiameter, self.dotDiameter);
    CGFloat angle = (_endAngle - _startAngle) * self.progress + _startAngle;
    CGFloat centerX = self.width/2 + progressRadius*cosf(DEGREES_TO_RADIANS(angle));
    CGFloat centerY = self.width/2 + progressRadius*sinf(DEGREES_TO_RADIANS(angle));
    _dotImageView.center = CGPointMake(centerX, centerY);
    _dotImageView.layer.cornerRadius = self.dotDiameter/2;
    [_dotImageView setImage:self.dotImage];
    _dotImageView.userInteractionEnabled = YES;
    [self addSubview:_dotImageView];
    
    UIPanGestureRecognizer *longGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(longGestureAction:)];
    [self.dotImageView addGestureRecognizer:longGesture];
    
    
}

- (void)longGestureAction:(UIPanGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan) {
        if([self.delegate respondsToSelector:@selector(mLMCircleViewDidBeginDrag:)]) {
            [self.delegate mLMCircleViewDidBeginDrag:self];
        }
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [gesture locationInView:self];
        CGFloat radius = progressRadius - (_progressWidth - _dotDiameter) / 2.0;
        CGFloat x = MAX(point.x, self.width / 2.0 - radius);
        x = MIN(x, self.width / 2.0 + radius);
       
        if (x < self.width / 2.0) {
            float cos = (self.width / 2.0 - x) / radius;
            float anle = acosf(cos);
            self.progress = anle / M_PI;
        }else{
            float cos = (x - self.width / 2.0) / radius;
            float anle = acosf(cos);
            self.progress = 1 - anle / M_PI;
        }
            
        if([self.delegate respondsToSelector:@selector(mLMCircleView:didChangePercent:)]) {
            [self.delegate mLMCircleView:self didChangePercent:self.progress];
        }
        
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
        if([self.delegate respondsToSelector:@selector(mLMCircleViewDidEndDrag:)]) {
           [self.delegate mLMCircleViewDidEndDrag:self];
       }
        
    }
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self drawProgress];
    [self dotCenter];
    
}



#pragma mark - draw
- (void)drawProgress {
    //
    CGFloat baseRadius = self.width/2 - _edgespace;
    
    //确保边缘距离设置正确
    if (_progressSpace == 0) {
        circleRadius = progressRadius = baseRadius - MAX(_progressWidth, _bottomWidth)/2;
    } else if (_progressSpace < 0) {
        circleRadius = baseRadius  - _bottomWidth/2;
        progressRadius = baseRadius - _progressWidth/2;
    } else {
        circleRadius = baseRadius - _bottomWidth/2;
        progressRadius = baseRadius - _bottomWidth/2 - _progressSpace;
    }
    
    //光标位置
    [self drowLayer];
}

- (void)drawDot{
    CGFloat angle = (_endAngle - _startAngle) * self.progress + _startAngle;
    CGFloat centerX = self.width/2 + progressRadius*cosf(DEGREES_TO_RADIANS(angle));
    CGFloat centerY = self.width/2 + progressRadius*sinf(DEGREES_TO_RADIANS(angle));
    _dotImageView.center = CGPointMake(centerX, centerY);
}

#pragma mark - layer
- (void)drowLayer {
    [self drowBottom];
    [self drowProgress];
}



- (void)drowBottom {
    //背景
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2, self.height/2)
                                                                radius:circleRadius
                                                            startAngle:DEGREES_TO_RADIANS(_startAngle)
                                                              endAngle:DEGREES_TO_RADIANS(_endAngle)
                                                             clockwise:YES];
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = CGRectMake(0, 0, self.width, self.height);
    self.bottomLayer.fillColor = [UIColor clearColor].CGColor;
    self.bottomLayer.strokeColor = self.bgColor.CGColor;
    if (_capRound) {
        self.bottomLayer.lineCap = kCALineCapRound;
    }
    self.bottomLayer.lineWidth = self.bottomWidth;
    self.bottomLayer.path = [bottomPath CGPath];
    [self.layer addSublayer:self.bottomLayer];
}

- (void)drowProgress {

//    [self.progressLayer removeFromSuperlayer];
//    [self.gradientLayer removeFromSuperlayer];
    if (self.progressLayer) {
        [self.progressLayer removeFromSuperlayer];
    }else{
        self.progressLayer = [CAShapeLayer layer];

    }
    
    if (self.gradientLayer) {
        [self.gradientLayer removeFromSuperlayer];
    }

    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2, self.height/2)
                                                              radius:progressRadius
                                                          startAngle:DEGREES_TO_RADIANS(_startAngle)
                                                            endAngle:DEGREES_TO_RADIANS(_endAngle)
                                                           clockwise:YES];
    self.progressLayer.frame = CGRectMake(0, 0, self.width, self.height);
    self.progressLayer.fillColor =  [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor  = self.fillColor.CGColor;
    self.progressLayer.strokeEnd = self.progress;


    if (_capRound) {
        self.progressLayer.lineCap = kCALineCapRound;
    }
    self.progressLayer.lineWidth = self.progressWidth;
    self.progressLayer.path = [progressPath CGPath];
        
    _gradientLayer = [[CAGradientLayer alloc] init];
    _gradientLayer.frame = self.progressLayer.bounds;
    _gradientLayer.startPoint = CGPointMake(0, 0.5);
    _gradientLayer.endPoint = CGPointMake(1, 0.5);
    if (self.gradualColor == nil) {
        self.gradualColor = [UIColor colorWithRed:(72)/255.f green:(133)/255.f blue:(241)/255.f alpha:1];
    }
    CGColorRef color1 = [self.gradualColor colorWithAlphaComponent:0].CGColor;
    CGColorRef color2 = [self.gradualColor colorWithAlphaComponent:0.75].CGColor;
    CGColorRef color3 = [self.gradualColor colorWithAlphaComponent:0.85].CGColor;
    CGColorRef color4 = [self.gradualColor colorWithAlphaComponent:0.95].CGColor;
   
    _gradientLayer.colors = @[(__bridge id)color1, (__bridge id)color2, (__bridge id)color3, (__bridge id)color4];
    _gradientLayer.mask = self.progressLayer;
    
    if (_isTransparent) {
        [self.layer insertSublayer:_gradientLayer atIndex:0];

    }else{
        [self.layer addSublayer:self.progressLayer];
    }
    
            
}

- (void)setGradualColor:(UIColor *)gradualColor
{
    _gradualColor = gradualColor;
    [self drawProgress];
}

#pragma mark - 动画
- (void)createAnimation {
    CGFloat centerX = self.width/2 + progressRadius*cosf(DEGREES_TO_RADIANS(_endAngle - _startAngle)*lastProgress);
    CGFloat centerY = self.width/2 + progressRadius*sinf(DEGREES_TO_RADIANS(_endAngle - _startAngle)*lastProgress);
    _dotImageView.center = CGPointMake(centerX, centerY);
    
    //设置动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;//使得动画均匀进行
    //动画结束不被移除
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.rotationMode = kCAAnimationRotateAuto;
    pathAnimation.duration = kAnimationTime;
    pathAnimation.repeatCount = 1;

    
    //设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();

    CGPathAddArc(path,
                 NULL,
                 self.width/2,
                 self.height/2,
                 progressRadius,
                 DEGREES_TO_RADIANS(_endAngle - _startAngle)*lastProgress + DEGREES_TO_RADIANS(_startAngle),
                 DEGREES_TO_RADIANS(_endAngle - _startAngle)*_progress + DEGREES_TO_RADIANS(_startAngle), lastProgress > _progress);
    pathAnimation.path=path;
    CGPathRelease(path);
    [self.dotImageView.layer addAnimation:pathAnimation forKey:@"moveMarker"];
}

#pragma mark - 弧度
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
//    self.progressLayer.strokeEnd = progress;
    [self.progressLayer removeAnimationForKey:@"strokeEndAnimation"];
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 0.001f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:progress];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.progressLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
        
    [self drawDot];

//    self.progressLayer.strokeStart = 0;

//    [self drawRect:self.bounds];
}

- (void)setProgressAnimation:(BOOL)animation {
//    if (_progress == lastProgress) {
//        return;
//    }
//    [self drawProgress];
   
//    [self createAnimation];
//    [self circleAnimation];
}


- (void)circleAnimation {
    //开启事务
    [CATransaction begin];
    //关闭动画
    [CATransaction setDisableActions:YES];
    self.progressLayer.strokeEnd = lastProgress;
    [CATransaction commit];
    

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = kAnimationTime;
    animation.repeatCount = 1;
    animation.fromValue = @(lastProgress);
    animation.toValue = @(_progress);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.1;
    [self.progressLayer addAnimation:animation forKey:@"strokeEndAni"];
    lastProgress = _progress;
}

- (void)dotHidden:(BOOL)hidden {
    _dotImageView.hidden = hidden;
}

- (CGFloat)freeWidth {
    //最小半径
    CGFloat cirle = circleRadius - _bottomWidth/2;
    CGFloat progress = progressRadius - _progressWidth/2;
    return MIN(cirle, progress)*2;

}

- (void)bottomNearProgress:(BOOL)outOrIn {
    CGFloat nearSpace = (self.bottomWidth+self.progressWidth)/2;
    if (outOrIn) {
        self.progressSpace = -nearSpace;
    } else {
        self.progressSpace = nearSpace;
    }
}

@end
