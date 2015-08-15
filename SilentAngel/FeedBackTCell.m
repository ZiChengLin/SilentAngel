//
//  FeedBackTCell.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/20.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "FeedBackTCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation FeedBackTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.weiQImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, HEIGHT/20 - 16, 32, 32)];
        //_weiQImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_weiQImageView];
        
        self.weiQLabel = [[UILabel alloc] initWithFrame:CGRectMake(52 + 20, 5, WIDTH-92, HEIGHT/10-10)];
        //_weiQLabel.backgroundColor = [UIColor orangeColor];
        _weiQLabel.font = [UIFont systemFontOfSize:16];
        _weiQLabel.numberOfLines = 0;
        [self.contentView addSubview:_weiQLabel];
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
