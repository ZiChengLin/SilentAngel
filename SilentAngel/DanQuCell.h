//
//  DanQuCell.h
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DanQu;
@interface DanQuCell : UITableViewCell

@property (nonatomic, strong) UILabel     *musician_idLabel;
@property (nonatomic, strong) UILabel     *tagsLabel;
@property (nonatomic, strong) UIImageView *imageurlView;
@property (nonatomic, strong) UIButton    *playPauseBtn;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *artistLabel;
@property (nonatomic, strong) UILabel     *remarkLabel;
@property (nonatomic, strong) UILabel     *public_dateLabel;

@property (nonatomic, strong) DanQu       *danqu;

+ (CGFloat)cellContentHeight:(DanQu *)danqu;

@end
