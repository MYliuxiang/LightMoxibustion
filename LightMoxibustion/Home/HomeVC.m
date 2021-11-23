//
//  HomeVC.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "HomeVC.h"

#import "CRC16.h"
#import "IntToByte.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"首页";
    TemperaturePkg *tpkg = [[TemperaturePkg alloc] initWithTemperature:30];

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
