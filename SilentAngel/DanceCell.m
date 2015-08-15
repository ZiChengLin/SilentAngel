//
//  DanceCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DanceCell.h"
#import "Common.h"

@implementation DanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.danceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/2-50, 20, 100, 40)];
        //_danceLabel.backgroundColor = [UIColor orangeColor];
        _danceLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_danceLabel];
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
