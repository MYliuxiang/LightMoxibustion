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
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    UIViewController *rootVC = [[HomeVC alloc] init];
    UINavigationController *navVC = [[BaseNavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];

    [[AppService shareInstance] registerAppService:application didFinishLaunchingWithOptions:launchOptions];
//
//    NSError *activationErr =nil;
//
//    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
//
//    [[AVAudioSession sharedInstance] setActive: YES error:&activationErr];
//
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
//    exit(0);
//    UIApplication*   app = [UIApplication sharedApplication];
//       __block    UIBackgroundTaskIdentifier bgTask;
//       bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//           dispatch_async(dispatch_get_main_queue(), ^{
//               if (bgTask != UIBackgroundTaskInvalid)
//               {
//                   bgTask = UIBackgroundTaskInvalid;
//               }
//           });
//       }];
//       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//           dispatch_async(dispatch_get_main_queue(), ^{
//               if (bgTask != UIBackgroundTaskInvalid)
//               {
//                   bgTask = UIBackgroundTaskInvalid;
//               }
//           });
//       });
}

- (void)applicationWillResignActive:(UIApplication *)application
{
//    exit(0);
}





@end
