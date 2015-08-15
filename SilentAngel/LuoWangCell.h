//
//  LuoWangCell.h
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LuoWang;
@interface LuoWangCell : UITableViewCell

@property (nonatomic, strong) UILabel     *numberLabel;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *tagsLabel;
@property (nonatomic, strong) UIImageView *imageurlView;
@property (nonatomic, strong) UILabel     *commLabel;
@property (nonatomic, strong) UILabel     *favLabel;

@property (nonatomic, strong) LuoWang     *luo;

@end
