//
//  BaseTabBarViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/28.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "MusicViewController.h"
#import "LifeViewController.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>
{
    UINavigationController *navigationController;
    UINavigationController *lifeNavigationController;

}

@end

@implementation BaseTabBarViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self initViewController];
        
    }
    return self;
}

- (void)initViewController {
    
    MusicViewController *musicViewController = [[MusicViewController alloc] init];
    navigationController = [[UINavigationController alloc] initWithRootViewController:musicViewController];
    
    navigationController.tabBarItem.title = @"音悦MUSIC";
    navigationController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -12);
    navigationController.tabBarItem.image = [[UIImage imageNamed:@"dot_white.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"dot.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navigationController.tabBarItem setImageInsets:UIEdgeInsetsMake(10, -37, -10, 37)];
    
    LifeViewController *lifeViewController = [[LifeViewController alloc] init];
    lifeNavigationController = [[UINavigationController alloc] initWithRootViewController:lifeViewController];
    
    lifeNavigationController.tabBarItem.title = @"单曲SINGLE";
    lifeNavigationController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -12);
    lifeNavigationController.tabBarItem.image = [[UIImage imageNamed:@"dot_white.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    lifeNavigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"dot.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [lifeNavigationController.tabBarItem setImageInsets:UIEdgeInsetsMake(10, -40, -10, 40)];
    
    NSArray *array = @[navigationController, lifeNavigationController];
    self.viewControllers = array;
    self.delegate = self;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName,[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mbg"] forBarMetrics:UIBarMetricsDefault];
}

#pragma -mark 通过协议方法监听当前点击的是哪个tabBarItem
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    //NSLog(@"%lu", tabBarController.selectedIndex);
    //NSLog(@"%@", tabBarController.selectedViewController);
    
    [tabBarController.selectedViewController popoverPresentationController];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
