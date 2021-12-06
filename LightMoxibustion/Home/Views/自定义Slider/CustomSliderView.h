#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface CustomSliderView : UIView
@property (nonatomic ,assign) CGFloat progress;
@property (nonatomic ,strong) NSArray *baifenbiArr;
@property (nonatomic ,strong) UIColor *normalBgColor;
@property (nonatomic ,strong) UIColor *selectedBgColor;
@property (nonatomic ,strong) UIColor *normalCycleColor;
@property (nonatomic ,strong) UIColor *selectedCycleColor;
@property (nonatomic ,strong) UIColor *currentCycleColor;
@property (nonatomic ,strong) UIColor *currentCycleBoardColor;
@property (nonatomic ,strong) UIImage *currentCycleImage;
@property (nonatomic ,assign) NSInteger currentIndex;
@property (nonatomic ,strong) void(^selectedIndexCallback)(NSInteger index, NSString *valueStr);
@property (nonatomic ,assign) BOOL hideTopIndex;
@end
NS_ASSUME_NONNULL_END
