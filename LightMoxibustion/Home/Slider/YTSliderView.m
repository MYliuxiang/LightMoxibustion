//
//  YTVolumeSliderView.m
//  YTSliderView
//
//  Created by yitezh on 2019/10/18.
//  Copyright © 2019 yitezh. All rights reserved.
//

#import "YTSliderView.h"
@interface YTSliderView() {
    CGFloat max_thumbArea_v;
    CGFloat min_thumbArea_v;
    CGFloat thumbArea_length;
    CGFloat thumbSizeValue;
    CGFloat anchorPosition;
    CGFloat trackWidth;
    CGFloat trackHeight;
}

@property (strong, nonatomic)UIView *backgroundView;

@property (strong, nonatomic)UIView *progressView;

@property (strong, nonatomic)UIView *trackContView;

@property (strong, nonatomic)UIView *thumbView;




@end

@implementation YTSliderView

- (instancetype)initWithFrame:(CGRect)frame setting:(YTSliderSetting *)setting {
    if(self == [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        [self initSubView];
        [self setSetting:setting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame setting:[YTSliderSetting defaultSetting]];
}

- (void)initData {
    trackWidth = self.frame.size.width - 2*_setting.progressInset;
    trackHeight = self.frame.size.height - 2*_setting.progressInset;

    if(_setting.layoutDirection == YTSliderLayoutDirectionHorizontal) {
        thumbSizeValue = trackHeight;
        min_thumbArea_v = thumbSizeValue/2;
        max_thumbArea_v = trackWidth - thumbSizeValue/2;
        if([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
            self.transform = CGAffineTransformScale(self.transform, -1.0, 1.0);
        }
    }
    else {
        thumbSizeValue = 35 * WidthScale;
        min_thumbArea_v = 0;
        max_thumbArea_v = trackHeight ;
        self.transform = CGAffineTransformScale(self.transform, 1.0, -1.0);
        self.thumbView.transform = CGAffineTransformScale(self.transform, 1.0, 1.0);

    }
    thumbSizeValue = 35 * WidthScale;
    thumbArea_length = self.backgroundView.height;
    
}

- (void)initSubView {
    [self addSubview:self.backgroundView];
    [self addSubview:self.trackContView];
    
    [self.trackContView addSubview:self.progressView];
    [self.trackContView addSubview:self.thumbView];
    
    UIPanGestureRecognizer *longGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(longGestureAction:)];
    [self.thumbView addGestureRecognizer:longGesture];
            
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    CGPoint tempPoint = [self.thumbView convertPoint:point fromView:self];
    if ([self.thumbView pointInside:tempPoint withEvent:event]) {
        return self.thumbView;
    }
    return view;
}

- (void)configView {
    self.backgroundView.backgroundColor = _setting.backgroundColor;
    self.progressView.backgroundColor = _setting.progressColor;
    self.thumbView.backgroundColor = _setting.thumbColor;
    self.thumbView.layer.borderColor = _setting.thumbBorderColor.CGColor;
    self.thumbView.layer.borderWidth = _setting.borderWidth;
    if ([_setting.thumbTitle isEqualToString:@"温度"]) {
        UIImage *thumbImage = [UIImage imageNamed:@"thumb_temp"];
        self.thumbView.layer.contents = (id)thumbImage.CGImage;

    }else if ([_setting.thumbTitle isEqualToString:@"频率"]){
        UIImage *thumbImage = [UIImage imageNamed:@"thumb_fre"];
        self.thumbView.layer.contents = (id)thumbImage.CGImage;

    }else if ([_setting.thumbTitle isEqualToString:@"红光"]){
        UIImage *thumbImage = [UIImage imageNamed:@"thumb_laser"];
        self.thumbView.layer.contents = (id)thumbImage.CGImage;
    }
    
    
    
    self.backgroundView.frame = self.bounds;
    self.progressView.frame = CGRectMake(0, 0, 0, trackHeight);
    self.trackContView.frame = CGRectMake(_setting.progressInset, _setting.progressInset,trackWidth, trackHeight);
    self.thumbView.frame = CGRectMake( - thumbSizeValue / 2.0, - thumbSizeValue / 2.0, thumbSizeValue, thumbSizeValue);
    
    
    self.backgroundView.layer.cornerRadius = trackWidth/2.0;
    self.progressView.layer.cornerRadius = trackWidth/2.0;
    self.thumbView.layer.cornerRadius = _thumbView.frame.size.width/2;
    
    for (int i = 0; i < _setting.step; i++) {
        UIView *pView = [[UIView alloc] initWithFrame:CGRectMake(0, trackHeight / (_setting.step + 1) * (i + 1) - 1 , trackWidth, 2)];
        pView.backgroundColor = [UIColor whiteColor];
        [self.trackContView insertSubview:pView belowSubview:self.thumbView];
       
    }
    
    UIImage *image = [[UIImage imageNamed:@"21681638779219"] imageByRotate180];
    self.progressView.layer.contents = (id)image.CGImage;
    self.progressView.clipsToBounds = YES;
    
}

- (void)setSetting:(YTSliderSetting *)setting {
    _setting = setting;
    [self initData];
    [self configView];
    [self layoutViewPosition];
    
}

- (void)setAnchorPercent:(CGFloat)anchorPercent {
    _anchorPercent = anchorPercent;
    [self layoutViewPosition];
    [self layoutProgress];
}

- (void)longGestureAction:(UIPanGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan) {
        if([self.delegate respondsToSelector:@selector(ytSliderViewDidBeginDrag:)]) {
            [self.delegate ytSliderViewDidBeginDrag:self];
        }
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        CGFloat minPosition = min_thumbArea_v;
        CGFloat maxPosition = max_thumbArea_v;
        
        CGPoint point = [gesture locationInView:self];
        
        CGFloat movePosition = 0;
        CGFloat percent = 0 ;
        if(_setting.layoutDirection == YTSliderLayoutDirectionHorizontal) {
            movePosition = MAX(minPosition, point.x);
            movePosition = MIN(maxPosition, movePosition);
            self.thumbView.center = CGPointMake(movePosition, self.thumbView.center.y);
            percent = (self.thumbView.center.x - anchorPosition)/thumbArea_length ;
        }
        else {
           
            movePosition = MAX(minPosition, point.y);
            movePosition = MIN(maxPosition, movePosition);
            self.thumbView.center = CGPointMake(self.thumbView.center.x, movePosition);
            percent = (self.thumbView.center.y - anchorPosition)/thumbArea_length ;
        }
        
        if(_setting.shouldShowProgress) {
            [self layoutProgress];
        }
        
        if([self.delegate respondsToSelector:@selector(ytSliderView:didChangePercent:)]) {
            _currentPercent = percent;
            [self.delegate ytSliderView:self didChangePercent:percent];
        }
        
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
         if([self.delegate respondsToSelector:@selector(ytSliderViewDidEndDrag:)]) {
           [self.delegate ytSliderViewDidEndDrag:self];
       }
    }
}


- (void)layoutProgress {
    if(_setting.layoutDirection == YTSliderLayoutDirectionHorizontal) {
        CGFloat progressStart = MIN(_anchorPercent*trackWidth, CGRectGetMinX(self.thumbView.frame));
        CGFloat progressEnd = MAX(_anchorPercent*trackWidth, CGRectGetMaxX(self.thumbView.frame));
        self.progressView.frame = CGRectMake(progressStart, self.progressView.frame.origin.y,progressEnd - progressStart,trackHeight);
    }
    else {
//        CGFloat progressStart = MIN(_anchorPercent*trackHeight, CGRectGetMinY(self.thumbView.frame));
//        CGFloat progressEnd = MAX(_anchorPercent*trackHeight, CGRectGetMaxY(self.thumbView.frame));
        
        self.progressView.frame = CGRectMake(self.progressView.frame.origin.x, 0,trackWidth,_currentPercent * trackHeight);
    }
        
}


- (void)layoutViewPosition {
    if(_setting.layoutDirection == YTSliderLayoutDirectionHorizontal) {
        anchorPosition = min_thumbArea_v + (trackWidth - thumbSizeValue)*_anchorPercent;
        self.trackContView.center = CGPointMake(self.trackContView.center.x, self.frame.size.height/2);
        self.thumbView.center = CGPointMake(anchorPosition, trackHeight/2);

    }
    else {
        anchorPosition = min_thumbArea_v + (trackHeight - thumbSizeValue)*_anchorPercent;
        self.trackContView.center = CGPointMake(self.trackContView.center.x, self.frame.size.height/2);
        self.thumbView.center = CGPointMake(trackWidth/2, 0);

    }
}

#pragma mark - setter

- (void)setCurrentPercent:(CGFloat)currentPercent {
    CGFloat minPercent = 0 - _anchorPercent;
    CGFloat maXPercent = 1 - _anchorPercent;
    
    _currentPercent = currentPercent;
    _currentPercent = MAX(minPercent, _currentPercent);
    _currentPercent = MIN(maXPercent, _currentPercent);
    
    CGFloat center_v = thumbArea_length * _currentPercent+anchorPosition;
    if(_setting.layoutDirection == YTSliderLayoutDirectionHorizontal) {
        self.thumbView.center = CGPointMake(center_v, self.thumbView.center.y);
    }
    else {
       
        self.thumbView.center = CGPointMake(self.thumbView.center.x, _currentPercent * self.height);
    }
    
    [self layoutProgress];
}


- (void)doTapicEngine{
    UIImpactFeedbackGenerator *impcat = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
    [impcat prepare];
    [impcat performSelector:@selector(impactOccurred) withObject:nil];
}

#pragma mark - getter
- (UIView *)backgroundView {
    if(!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.layer.cornerRadius = thumbSizeValue/2;
       
    }
    return _backgroundView;
}

- (UIView *)progressView {
    if(!_progressView) {
        _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, trackHeight)];
        _progressView.backgroundColor = [UIColor colorWithRed:43/255.0 green:157/255.0 blue:247/255.0 alpha:1.0];
        _progressView.layer.cornerRadius = thumbSizeValue/2;
       
    }
    return _progressView;
}

- (UIView *)trackContView {
    if(!_trackContView) {
        _trackContView = [[UIView alloc]initWithFrame:CGRectMake(_setting.progressInset, _setting.progressInset,trackWidth, trackHeight)];
        
    }
    return _trackContView;
}

- (UIView *)thumbView {
    if(!_thumbView) {
        _thumbView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, thumbSizeValue, thumbSizeValue)];
        _thumbView.layer.borderWidth = 4;
        _thumbView.layer.borderColor =  [UIColor colorWithRed:43/255.0 green:157/255.0 blue:247/255.0 alpha:1.0].CGColor;
        _thumbView.backgroundColor = [UIColor whiteColor];
        _thumbView.layer.cornerRadius = _thumbView.frame.size.width/2;
        
    }
    return _thumbView;
}


@end
