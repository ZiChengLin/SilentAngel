//
//  AppDelegate.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/28.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (void)setupNavigationBarStyle {
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    // iOS7以上才可以设置下面几个属性
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        // 设置导航栏的背景颜色
        //[appearance setBarTintColor:[UIColor colorWithRed:255.0/255 green:251.0/255 blue:255.0/255 alpha:0.001]];
        
        [appearance setBarTintColor:[UIColor clearColor]];
        // 设置导航栏的返回按钮或者系统按钮的文字颜色
        //[appearance setTintColor:[UIColor clearColor]];
        // 设置导航栏的title文字颜色
        [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor blackColor],
                                            NSForegroundColorAttributeName,
                                            [UIFont systemFontOfSize:17],
                                            NSFontAttributeName, nil]];
    } else {
        // 设置导航栏的背景颜色
        //[appearance setTintColor:[UIColor colorWithRed:0.291 green:0.607 blue:1.000 alpha:1.000]];
        [appearance setBarTintColor:[UIColor clearColor]];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //[self setupNavigationBarStyle];
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor blackColor],
                                        NSForegroundColorAttributeName,
                                        [UIFont systemFontOfSize:17],
                                        NSFontAttributeName, nil]];
    
    BaseTabBarViewController *baseTabBarViewController = [[BaseTabBarViewController alloc] init];
    baseTabBarViewController.delegate = self;
    self.window.rootViewController = baseTabBarViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}


// UITabbarController点击tabbar选项返回当前viewController最顶层
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    [(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
    
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
