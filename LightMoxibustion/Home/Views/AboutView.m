//
//  AboutView.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/18.
//

#import "AboutView.h"

@implementation AboutView

- (instancetype)initAlert{
    
    self = [super init];
    if (self) {
        
        self.width = kScreenWidth - 100;
        self.doneB.layer.cornerRadius = 15;
        self.doneB.layer.masksToBounds = YES;
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        CFShow((__bridge CFTypeRef)(infoDictionary));
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        self.appVersionL.text = [NSString stringWithFormat:@"APP版本:V%@",app_Version];
        
        NSString *blueVersion = [NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:BlueVersion]];
        if (blueVersion.length == 0 || [blueVersion isEqualToString:@"(null)"]) {
            blueVersion = @"3.0.1";
        }
        
        
        self.blueVersionL.text = [NSString stringWithFormat:@"固件版本:V%@",blueVersion];
        
        [self setupAutoHeightWithBottomView:self.doneB bottomMargin:30];
        
        LXViewBorder(self, 5);
                       
    }
    return self;
    
}

- (IBAction)doneAC:(id)sender {
    [self disMiss];
}



@end
