//
//  AppDelegate.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "AppService.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //打印日志
    BANetManagerShare.isOpenLog = YES;
//    //设置网络请求头
//    NSString *user_token = [NSString stringWithFormat:@"%@",[LoginManger sharedManager].currentLoginModel.token];
//    NSDictionary *headerdic = @{@"token":user_token};
//    [BANetManager sharedBANetManager].httpHeaderFieldDictionary = headerdic;
   
    //
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    


        
    UIViewController *rootVC = [[HomeVC alloc] init];
    UINavigationController *navVC = [[BaseNavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];

    [[AppService shareInstance] registerAppService:application didFinishLaunchingWithOptions:launchOptions];
    
    
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    exit(0);
}



@end
