//
//  CollectionCell.h
//  SilentAngel
//
//  Created by 林梓成 on 15/8/8.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneKindList;
@interface CollectionCell : UITableViewCell

@property (nonatomic, strong) UIImageView *songphotoImageView;
@property (nonatomic, strong) UILabel     *songerLabel;
@property (nonatomic, strong) UILabel     *songnameLabel;

@property (nonatomic, strong) OneKindList *oneKindList;

@end
