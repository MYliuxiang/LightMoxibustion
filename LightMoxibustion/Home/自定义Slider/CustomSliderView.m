#import "CustomSliderView.h"
#import "UIColor+Extension.h"
#import "UIView+Extensionss.h"
#import "Masonry.h"
#define cycleViewWidth   8
#define currentCycleViewWidth   15
#define LineHeight       3
#define NormalViewBgColor  [UIColor colorWithHexString:@"#f4f4f4"];
#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define ScaleW(width)  width*VIEW_WIDTH/375
#define systemFont(x) [UIFont systemFontOfSize:x]
@interface CustomSliderView ()
@property (nonatomic ,strong) UIView *bellowView;
@property (nonatomic ,strong) UIView *upView;
@property (nonatomic ,strong) UIImageView *currentCycleView;
@property (nonatomic ,strong) UIButton *currentProgressLb;
@property (nonatomic ,strong) UIView *bottomIndexView;
@property (nonatomic ,strong) NSMutableArray <UIView *>*cycleViewArrM;
@property (nonatomic ,strong) NSMutableArray <UILabel *>*indexLabelArrM;
@property (nonatomic ,strong) NSMutableArray *indexLbArrM;
@end
@implementation CustomSliderView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.normalBgColor = NormalViewBgColor;
    self.selectedBgColor = UIColor.blueColor;
    self.normalCycleColor = NormalViewBgColor;
    self.selectedCycleColor = UIColor.blueColor;
    self.currentCycleColor =  UIColor.blueColor;;
    [self addSubview:self.bellowView];
    [self.bellowView addSubview:self.upView];
    [self addSubview:self.currentCycleView];
    [self addSubview:self.currentProgressLb];
    [self addSubview:self.bottomIndexView];
    self.bellowView.layer.masksToBounds = YES;
    self.currentCycleView.backgroundColor = UIColor.whiteColor;
    self.currentCycleView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.currentCycleView addGestureRecognizer:pan];
    self.baifenbiArr = @[@"关闭", @"1",@"2", @"3", @"4",@"5"];
}
- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint transP = [pan translationInView:self.currentCycleView];
    if (CGRectGetMinX(self.currentCycleView.frame) <= 0) {
        self.currentCycleView.frame = CGRectMake(0, self.currentCycleView.frame.origin.y, self.currentCycleView.frame.size.width, self.currentCycleView.frame.size.height);
    }
    if (CGRectGetMaxX(self.currentCycleView.frame) >= CGRectGetWidth(self.frame)) {
        self.currentCycleView.frame = CGRectMake(CGRectGetWidth(self.frame) - currentCycleViewWidth, self.currentCycleView.frame.origin.y, self.currentCycleView.frame.size.width, self.currentCycleView.frame.size.height);
    }
    self.currentCycleView.transform = CGAffineTransformTranslate(self.currentCycleView.transform, transP.x, 0);
    [pan setTranslation:CGPointZero inView:self.currentCycleView];
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGFloat currentDestence = self.currentCycleView.x + currentCycleViewWidth * 0.5;
        self.upView.x = self.currentCycleView.x;
        self.currentProgressLb.x = self.currentCycleView.origin.x - cycleViewWidth * 0.5;
        for (int i = 0; i < self.cycleViewArrM.count; i++) {
            UIView *currentV = self.cycleViewArrM[i];
            if (currentV.center.x >= (currentDestence)) {
                currentV.backgroundColor = self.normalCycleColor;
            }else{
                currentV.backgroundColor = self.selectedBgColor;
            }
        }
        NSInteger currentIndex = [self getCurrentIndex];
        [self.currentProgressLb setTitle:[NSString stringWithFormat:@"%@", self.baifenbiArr[currentIndex]] forState:UIControlStateNormal];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self jisuanDestence];
    }
}
- (NSInteger) getCurrentIndex{
    CGFloat currentDestence = self.currentCycleView.frame.origin.x;
    CGFloat totalDestence = self.bellowView.bounds.size.width;
    CGFloat itemDestence = totalDestence / (self.baifenbiArr.count - 1);
    NSInteger currentIndex = currentDestence / itemDestence;
    CGFloat destence  = currentDestence - currentIndex * itemDestence;
    currentIndex = currentIndex;
    if (destence > itemDestence * 0.5) {
        currentIndex  = currentIndex + 1;
    }else{
    }
    if (currentIndex >= self.self.baifenbiArr.count) {
        currentIndex = self.self.baifenbiArr.count - 1;
    }
    if (currentIndex <= 0) {
        currentIndex = 0;
    }
    return currentIndex;
}
- (void) jisuanDestence{
    CGFloat centerX = CGRectGetMaxX(self.currentCycleView.frame) - currentCycleViewWidth * 0.5;
    for (long i = self.cycleViewArrM.count - 1; i >= 0; i--) {
        UIView *cycleView = self.cycleViewArrM[i];
    }
    CGFloat currentDestence = self.currentCycleView.frame.origin.x;
    CGFloat totalDestence = self.bellowView.bounds.size.width;
    CGFloat itemDestence = totalDestence / (self.baifenbiArr.count - 1);
    NSInteger currentIndex = currentDestence / itemDestence;
    CGFloat destence  = currentDestence - currentIndex * itemDestence;
    currentIndex = currentIndex;
    if (destence > itemDestence * 0.5) {
        currentIndex  = currentIndex + 1;
    }else{
    }
    if (currentIndex >= self.self.baifenbiArr.count) {
        currentIndex = self.self.baifenbiArr.count - 1;
    }
    if (currentIndex <= 0) {
        currentIndex = 0;
    }
    UIView *currentV = self.cycleViewArrM[currentIndex];
    self.currentCycleView.frame = CGRectMake(currentV.center.x - currentCycleViewWidth * 0.5, self.currentCycleView.frame.origin.y, self.currentCycleView.frame.size.width, self.currentCycleView.frame.size.height);
    self.upView.x = currentV.center.x - currentCycleViewWidth * 0.5;
    for (int i = 0; i < self.cycleViewArrM.count; i++) {
        UIView *currentV = self.cycleViewArrM[i];
        if (i >= currentIndex + 1) {
            currentV.backgroundColor = self.normalCycleColor;
        }else{
            currentV.backgroundColor = self.selectedCycleColor;
        }
    }
    self.currentProgressLb.x = self.currentCycleView.frame.origin.x - cycleViewWidth * 0.5;
    [self.currentProgressLb setTitle:[NSString stringWithFormat:@"%@", self.baifenbiArr[currentIndex]] forState:UIControlStateNormal];
    !self.selectedIndexCallback ? : self.selectedIndexCallback(currentIndex, self.baifenbiArr[currentIndex]);
}
- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [self layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat totalDestence = self.bellowView.bounds.size.width;
        CGFloat itemDestence = totalDestence / (self.baifenbiArr.count - 1);
        self.currentCycleView.frame = CGRectMake(itemDestence * currentIndex, self.currentCycleView.frame.origin.y, self.currentCycleView.frame.size.width, self.currentCycleView.frame.size.height);
        self.upView.x = self.currentCycleView.frame.origin.x;
        for (int i = 0; i < self.cycleViewArrM.count; i++) {
            UIView *currentV = self.cycleViewArrM[i];
            if (i >= currentIndex + 1) {
                currentV.backgroundColor = self.normalCycleColor;
            }else{
                currentV.backgroundColor = self.selectedCycleColor;
            }
        }
        self.currentProgressLb.x = self.currentCycleView.frame.origin.x - cycleViewWidth * 0.5;
        [self.currentProgressLb setTitle:[NSString stringWithFormat:@"%@X", self.baifenbiArr[currentIndex]] forState:UIControlStateNormal];
    });
    !self.selectedIndexCallback ? : self.selectedIndexCallback(currentIndex, self.baifenbiArr[currentIndex]);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.currentProgressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(ScaleW(5));
        make.height.mas_equalTo(ScaleW(14));
        make.width.mas_equalTo(ScaleW(25));
        make.centerX.mas_equalTo(self.currentCycleView);
    }];
    [self.bellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(currentCycleViewWidth * 0.5);
        make.right.mas_equalTo(self).offset(-currentCycleViewWidth * 0.5);
        make.height.mas_equalTo(LineHeight);
        make.centerY.mas_equalTo(self);
    }];
    [self.upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bellowView);
    }];
    [self.currentCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bellowView.mas_left);
        make.centerY.mas_equalTo(self.bellowView);
        make.width.height.mas_equalTo(currentCycleViewWidth);
    }];
    [self.bottomIndexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bellowView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self);
    }];
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
}
- (void)setBaifenbiArr:(NSArray *)baifenbiArr{
    _baifenbiArr = baifenbiArr;
    for (UIView *vvv in self.cycleViewArrM) {
        [vvv removeFromSuperview];
    }
    for (UIView *vvv in self.indexLbArrM) {
        [vvv removeFromSuperview];
    }
    [self.cycleViewArrM removeAllObjects];
    [self.indexLbArrM removeAllObjects];
    [self.currentProgressLb setTitle:[NSString stringWithFormat:@"%@", self.baifenbiArr.firstObject] forState:UIControlStateNormal];
    [self addCycleViews];
    [self addIndexViews];
}
- (void) addCycleViews{
    [self layoutIfNeeded];
    [self.cycleViewArrM removeAllObjects];
    for (int i = 0; i < self.baifenbiArr.count; i++) {
        UIView *cycleView = [[UIView alloc] init];
        [self.cycleViewArrM addObject:cycleView];
        cycleView.backgroundColor = self.normalCycleColor;
        cycleView.layer.cornerRadius = cycleViewWidth * 0.5;
        cycleView.layer.masksToBounds = YES;
        cycleView.backgroundColor = self.normalBgColor;
        [self insertSubview:cycleView belowSubview:self.currentCycleView];
    }
    CGFloat startPoint = (currentCycleViewWidth - cycleViewWidth) * 0.5;
    [self.cycleViewArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:cycleViewWidth leadSpacing:startPoint tailSpacing:startPoint];
    [self.cycleViewArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(cycleViewWidth);
    }];
}
- (void)setHideTopIndex:(BOOL)hideTopIndex{
    _hideTopIndex = hideTopIndex;
    self.currentProgressLb.hidden = hideTopIndex;
}
- (void) addIndexViews{
    [self layoutIfNeeded];
    for (UILabel *index in self.indexLabelArrM) {
        [index removeFromSuperview];
    }
    [self.indexLabelArrM removeAllObjects];
    for (int i = 0; i < self.baifenbiArr.count; i++) {
        UILabel *indexLb = [[UILabel alloc] init];
        [self.indexLabelArrM addObject:indexLb];
        indexLb.font = systemFont(10);
        indexLb.textColor = UIColor.blackColor;
        indexLb.text = [NSString stringWithFormat:@"%@", self.baifenbiArr[i]];
        indexLb.textAlignment = NSTextAlignmentCenter;
        [self insertSubview:indexLb aboveSubview:self.currentCycleView];
        [indexLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset(-4);
            make.centerX.mas_equalTo(self.cycleViewArrM[i].mas_centerX);
        }];
    }
}
- (void)setSelectedBgColor:(UIColor *)selectedBgColor{
    _selectedBgColor = selectedBgColor;
//    self.bellowView.backgroundColor = selectedBgColor;
}
- (void)setNormalBgColor:(UIColor *)normalBgColor{
    _normalBgColor = normalBgColor;
    self.upView.backgroundColor = normalBgColor;
}
- (void)setSelectedCycleColor:(UIColor *)selectedCycleColor{
    _selectedCycleColor = selectedCycleColor;
}
- (void)setNormalCycleColor:(UIColor *)normalCycleColor{
    _normalCycleColor = normalCycleColor;
}
- (void)setCurrentCycleColor:(UIColor *)currentCycleColor{
    _currentCycleColor = currentCycleColor;
    self.currentCycleView.backgroundColor = currentCycleColor;
}
- (void)setCurrentCycleImage:(UIImage *)currentCycleImage{
    _currentCycleImage = currentCycleImage;
    self.currentCycleView.image = currentCycleImage;
}
- (void)setCurrentCycleBoardColor:(UIColor *)currentCycleBoardColor{
    _currentCycleBoardColor = currentCycleBoardColor;
    self.currentCycleView.layer.borderColor = currentCycleBoardColor.CGColor;
}
- (UIView *)bellowView{
    if (!_bellowView) {
        _bellowView = [[UIView alloc] init];
//        _bellowView.backgroundColor = UIColor.blueColor;
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        //设置开始和结束位置(设置渐变的方向)
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(1, 0);
        gradient.frame =CGRectMake(0,0,300,20);
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,(id)[UIColor redColor].CGColor,nil];
        [_bellowView.layer insertSublayer:gradient atIndex:0];
    
        
    }
    return _bellowView;
}
- (UIView *)upView{
    if (!_upView) {
        _upView = [[UIView alloc] init];
        _upView.backgroundColor = NormalViewBgColor;
    }
    return _upView;
}
- (UIImageView *)currentCycleView{
    if (!_currentCycleView) {
        _currentCycleView = [[UIImageView alloc] init];
        _currentCycleView.contentMode = UIViewContentModeScaleAspectFit;
        _currentCycleView.layer.borderWidth = 10;
        _currentCycleView.layer.borderColor = UIColor.blueColor.CGColor;
        _currentCycleView.layer.cornerRadius = currentCycleViewWidth * 0.5;
        _currentCycleView.clipsToBounds = YES;
    }
    return _currentCycleView;
}
- (UIButton *)currentProgressLb{
    if (!_currentProgressLb) {
        _currentProgressLb = [[UIButton alloc] init];
        [_currentProgressLb setTitle:@"0.0" forState:UIControlStateNormal];
        _currentProgressLb.titleLabel.font = systemFont(8);
        [_currentProgressLb setBackgroundImage:[UIImage imageNamed:@"currentVlaueImg"] forState:UIControlStateNormal];
        [_currentProgressLb setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _currentProgressLb.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _currentProgressLb.userInteractionEnabled = NO;
    }
    return _currentProgressLb;
}
- (UIView *)bottomIndexView{
    if (!_bottomIndexView) {
        _bottomIndexView = [[UIView alloc] init];
    }
    return _bottomIndexView;
}
-(NSMutableArray *)cycleViewArrM{
    if (!_cycleViewArrM) {
        _cycleViewArrM = [NSMutableArray array];
    }
    return _cycleViewArrM;
}
- (NSMutableArray<UILabel *> *)indexLabelArrM{
    if (!_indexLabelArrM) {
        _indexLabelArrM = [NSMutableArray array];
    }
    return _indexLabelArrM;
}
- (NSMutableArray *)indexLbArrM{
    if (!_indexLbArrM) {
        _indexLbArrM = [NSMutableArray array];
    }
    return _indexLbArrM;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    NSLog(@"point    %lf     %lf", point.x, point.y);
    for (UIView *cycleView in self.cycleViewArrM) {
        CGFloat r = cycleViewWidth * 4 * 0.5;
        CGPoint p = cycleView.center;
        if (fabs(p.x - point.x) <= r && fabs(p.y - point.y) <= r) {
            NSInteger index = [self.cycleViewArrM indexOfObject:cycleView];
            self.currentIndex = index;
        }
    }
}
@end
