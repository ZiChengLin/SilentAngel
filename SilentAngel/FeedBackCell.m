//
//  FeedBackCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/20.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "FeedBackCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation FeedBackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, HEIGHT/12-10)];
        //_infoLabel.backgroundColor = [UIColor orangeColor];
        _infoLabel.text = @"添加心适微信账号或QQ反馈后攻城狮小城会第一时间解决问题";
        _infoLabel.numberOfLines = 0;
        _infoLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_infoLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
