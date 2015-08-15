//
//  AboutSceneCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/23.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "AboutSceneCell.h"

@implementation AboutSceneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.aboutImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _aboutImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_aboutImageView];
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
