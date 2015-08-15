//
//  MusicListCell.h
//  SilentAngel
//
//  Created by 林梓成 on 15/7/30.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneKindList;
@interface MusicListCell : UITableViewCell

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *songnameLabel;
@property (nonatomic, strong) UILabel *songer;

@property (nonatomic, strong) OneKindList *oneList;

@end
