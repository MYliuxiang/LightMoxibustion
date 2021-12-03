//
//  HomeVC.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "HomeVC.h"

#import "CRC16.h"
#import "IntToByte.h"
#import "MLMProgressView.h"
#import "CustomSliderView.h"
#import "LxUnitSlider.h"
#import "HRNumberUnitView.h"


#define PROGRESS_HEIGHT 200
#define LEFT_MAGAN 50



@interface HomeVC ()
@property (nonatomic ,strong) CustomSliderView *slider;
@property (nonatomic ,strong) HRNumberUnitView *numView;
@property (nonatomic ,assign) int number;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"首页";
    self.customNavBar.hidden = YES;
    
    
    TemperaturePkg *tpkg = [[TemperaturePkg alloc] initWithTemperature:30];

    MLMProgressView *progress = [[MLMProgressView alloc] initWithFrame:CGRectMake(LEFT_MAGAN , Height_NavBar + LEFT_MAGAN  , kScreenWidth - 2 * LEFT_MAGAN, kScreenWidth - 2 * LEFT_MAGAN)];
    [self.view addSubview:[progress speedDialType]];
    [progress tapHandle:^{
        [progress.circle setProgress:1];
        [progress.incircle setProgress:1];

    }];
//    progress.backgroundColor = [UIColor redColor];
//
//    LxUnitSlider *slider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, 200, 100, 300) titles:@[@"关闭",@"1",@"2",@"3",@"4",@"5"] total:50.0 thumbTitle:@"温度"];
//    [self.view addSubview:slider];
//
//
//    _numView = [[HRNumberUnitView alloc] initWithFrame:CGRectMake(50, 250, 50, 80)];
//    _numView.backgroundColor = [UIColor whiteColor];
//    _numView.fillColor = [UIColor redColor];
//    _numView.emptyColor = [[UIColor redColor] colorWithAlphaComponent:0.02];
//    [self.view addSubview:_numView];
//
//    _numView.number = 10;
    
//    [self performSelector:@selector(countNumber) withObject:nil afterDelay:0.5];
   

}

-(void)countNumber{
    _number ++;
    _numView.number = _number%10;
    
    [self performSelector:@selector(countNumber) withObject:nil afterDelay:0.5];
}

- (CustomSliderView *)slider{
    if (!_slider) {
        
        _slider = [[CustomSliderView alloc] init];
        _slider.selectedBgColor = UIColor.orangeColor;
        _slider.normalBgColor = [UIColor colorWithHexString:@"#f5f5f5"];
        _slider.currentCycleColor = UIColor.orangeColor;
        _slider.selectedCycleColor = UIColor.orangeColor;
        _slider.currentCycleBoardColor = [UIColor colorWithHexString:@"#E65E44"];
        _slider.selectedIndexCallback = ^(NSInteger index, NSString *valueStr) {
            NSLog(@"%ld----%@", index, valueStr);
        };
    }
    return _slider;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
