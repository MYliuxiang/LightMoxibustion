//
//  AboutVC.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/7.
//

#import "AboutVC.h"

@interface AboutVC ()
@property (weak, nonatomic) IBOutlet UILabel *versionL;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"关于";
    self.versionL.text = [NSString stringWithFormat:@"当前版本：%@",self.version];
}


@end
