//
//  LifeContentViewController.h
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "BaseViewController.h"

@interface LifeContentViewController : BaseViewController

@property (nonatomic, strong) NSString *imageurlString;
@property (nonatomic, strong) NSString *albumString;
@property (nonatomic, strong) NSString *artistString;

@property (nonatomic, strong) NSString *playurl_low;

@property (nonatomic) int songIndex;

@end
