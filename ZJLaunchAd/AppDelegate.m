//
//  AppDelegate.m
//  ZJLaunchAd
//
//  Created by ZeroJ on 16/10/9.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "AppDelegate.h"
#import "ZJLaunchAdController.h"
#import "ZJProgressHUD.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 请求服务器加载启动广告
    
    
//    NSString *adImageURLString = @"这是启动广告图片的URL";
//    NSString *adURLString = @"这是点击广告图片后的广告URL";
    
    ZJLaunchAdController *launchVc = [[ZJLaunchAdController alloc] initWithLaunchImage:nil setAdImageHandler:^(UIImageView *imageView) {
        // 这里可以直接使用SDWebimage等来请求服务器提供的广告图片(SDWebimage会处理好gif图片的显示)
        // 不过你需要注意选择SDWebimage的缓存策略
        imageView.image = [UIImage imageNamed:@"adImage"];
        
    } finishHandler:^(ZJLaunchAdCallbackType callbackType) {
        switch (callbackType) {
            case ZJLaunchAdCallbackTypeClickAd:
                // 点击了广告, 展示相应的广告即可
                NSLog(@"点击了广告, 展示相应的广告即可");
                [ZJProgressHUD showStatus:@"点击了广告, 展示相应的广告即可" andAutoHideAfterTime:1];
                break;
            case ZJLaunchAdCallbackTypeShowFinish:
                NSLog(@"展示广告图片结束, 可以进入App");
                [ZJProgressHUD showStatus:@"展示广告图片结束, 可以进入App"];

                break;
            case ZJLaunchAdCallbackTypeClickSkipBtn:
                NSLog(@"点击了跳过广告, 可以进入App");
                [ZJProgressHUD showStatus:@"点击了跳过广告, 可以进入App" andAutoHideAfterTime:1];

                break;
        }
    }];
    launchVc.countDownTime = 6.f;
    // 自定义广告图片的frame
//    launchVc.adImageViewFrame = [UIScreen mainScreen].bounds;
    [launchVc setSkipBtnHandler:^(UIButton *skipBtn, NSInteger currentTime) {
        [skipBtn setTitle:[NSString stringWithFormat:@"%lds 跳过", currentTime] forState:UIControlStateNormal];
    }];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = launchVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
