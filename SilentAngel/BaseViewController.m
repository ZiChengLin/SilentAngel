//
//  BaseViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/28.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 既然设定了基类视图 那么其他有关系的视图也都要继承它 不然会出现一些莫名其妙的视图位置问题
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
