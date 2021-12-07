//
//  AppService.m
//  BHGY
//
//  Created by liuxiang on 2020/7/3.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "AppService.h"

@implementation AppService
//单例
+ (instancetype)shareInstance
{
    static AppService *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
       
        
    }
    return self;
}

- (void)registerAppService:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self handleKeyBoard];
    
}

- (void)handleKeyBoard{
    //键盘处理
      IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
      manager.enable = YES;
      manager.shouldResignOnTouchOutside = YES;
      manager.shouldToolbarUsesTextFieldTintColor = YES;
      manager.enableAutoToolbar = NO;
    
    // wrnavgation
     [WRNavigationBar wr_widely];
     [WRNavigationBar wr_setBlacklist:@[@"TZImgePickHelper",@"TZImagePickerController",
     @"TZPhotoPickerController",
     @"TZGifPhotoPreviewController",
     @"TZAlbumPickerController",
     @"TZPhotoPreviewController",
     @"TZVideoPlayerController"]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];

//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
//                                                           NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    
    [SVProgressHUD setErrorImage:nil];
    [SVProgressHUD setForegroundColor:[[UIColor colorWithHexString:@"#E6E9EA"] colorWithAlphaComponent:0.3]];
    [SVProgressHUD setBackgroundColor:[UIColor redColor]];
    
}

@end

