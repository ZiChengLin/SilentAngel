//
//  CollectionCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/8.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "CollectionCell.h"
#import "OneKindList.h"
#import "Common.h"
#import "UIImageView+WebCache.h"

@implementation CollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {

    self.songphotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, KHEIGHT/6-10, KHEIGHT/8-10)];
    //_songphotoImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_songphotoImageView];
    
    self.songerLabel = [[UILabel alloc] initWithFrame:CGRectMake(_songphotoImageView.frame.size.width + 40, 10, KWIDTH-_songphotoImageView.frame.size.width-120, 20)];
    _songerLabel.font = [UIFont systemFontOfSize:13];
    //_songerLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_songerLabel];
    
    self.songnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_songphotoImageView.frame.size.width + 40, _songerLabel.frame.origin.y + 20, KWIDTH-_songphotoImageView.frame.size.width-60, KHEIGHT/8-10-25)];
    //_songnameLabel.backgroundColor = [UIColor yellowColor];
    _songnameLabel.font = [UIFont systemFontOfSize:18];
    _songnameLabel.numberOfLines = 0;
    [self.contentView addSubview:_songnameLabel];
}

- (void)setOneKindList:(OneKindList *)oneKindList {
    
    _oneKindList = oneKindList;
    
    _songerLabel.text = oneKindList.songer;
    _songnameLabel.text = oneKindList.songname;
    
    [_songphotoImageView sd_setImageWithURL:[NSURL URLWithString:oneKindList.songphoto] placeholderImage:[UIImage imageNamed:@"missing_article"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
