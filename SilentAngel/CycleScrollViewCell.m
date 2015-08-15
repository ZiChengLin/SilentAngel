//
//  CycleScrollViewCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/29.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "CycleScrollViewCell.h"
#import "MusicScrollViewController.h"

@interface CycleScrollViewCell ()

@end

@implementation CycleScrollViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        MusicScrollViewController *musicScrollViewController = [[MusicScrollViewController alloc] init];
        
        [self.contentView addSubview:musicScrollViewController.view];
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
