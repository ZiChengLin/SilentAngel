//
//  MusicListCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/30.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MusicListCell.h"
#import "OneKindList.h"
#import "Common.h"

@implementation MusicListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
    self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake((KWIDTH-KWIDTH*2/3)/2, 15, 30, 30)];
    //_indexLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_indexLabel];
    
    self.songnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/3, 5, KWIDTH/2, 30)];
    //_songnameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_songnameLabel];
    
    self.songer = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/3, 35, KWIDTH/2, 20)];
    //_songer.backgroundColor = [UIColor orangeColor];
    _songer.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_songer];
}

- (void)setOneList:(OneKindList *)oneList {
    
    _oneList = oneList;
    
    _songnameLabel.text = oneList.songname;
    _songer.text = oneList.songer;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
