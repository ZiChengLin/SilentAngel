//
//  MusicContentCell.h
//  SilentAngel
//
//  Created by 林梓成 on 15/7/30.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLabel.h"

@interface MusicContentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *ophotoImageView;
@property (nonatomic, strong) UILabel     *mnameLabel;
@property (nonatomic, strong) ZCLabel     *mdescLabel;

- (void)setMdescHeight:(NSString *)mdesc;

+ (CGFloat)cellContentHeight:(NSString *)content;

@end
