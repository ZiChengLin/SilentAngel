//
//  OneKindCell.h
//  SilentAngel
//
//  Created by 林梓成 on 15/7/29.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLabel.h"

@class OneKind;
@interface OneKindCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgCellView;

@property (nonatomic, strong) UIImageView *ophotoImageView;
@property (nonatomic, strong) UILabel     *mnameLabel;
@property (nonatomic, strong) ZCLabel     *mdescLabel;

@property (nonatomic, strong) OneKind     *one;

+ (CGFloat)cellContentHeight:(OneKind *)content;

@end
