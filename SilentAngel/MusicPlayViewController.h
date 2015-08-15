//
//  MusicPlayViewController.h
//  SilentAngel
//
//  Created by 林梓成 on 15/7/30.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class OneKindList;
@interface MusicPlayViewController : BaseViewController

@property (nonatomic, strong) NSString *songphotoString;
@property (nonatomic, strong) NSString *songerString;
@property (nonatomic, strong) NSString *songnameString;

@property (nonatomic, strong) NSString *filenameString;
@property (nonatomic, strong) NSString *songtimeString;

@property (nonatomic) int songIndex;   // 用来取本组歌单第几首歌

@property (nonatomic, strong) OneKindList *oneKindList;

@property (nonatomic, strong) NSString *isCollection;

@end
