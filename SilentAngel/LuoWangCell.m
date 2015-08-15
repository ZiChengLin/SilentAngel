//
//  LuoWangCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LuoWangCell.h"
#import "LuoWang.h"
#import "Common.h"

@implementation LuoWangCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    UILabel *vol = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 25, 30)];
    //vol.backgroundColor = [UIColor orangeColor];
    vol.text = @"vol.";
    vol.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:vol];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 25, 30)];
    //_numberLabel.backgroundColor = [UIColor greenColor];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_numberLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, KWIDTH-200, 30)];
    //_nameLabel.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_nameLabel];
    
    self.tagsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH-110, 5, 100, 30)];
    //_tagsLabel.backgroundColor = [UIColor orangeColor];
    _tagsLabel.textAlignment = NSTextAlignmentRight;
    _tagsLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_tagsLabel];
    
    self.imageurlView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, KWIDTH, KHEIGHT/3)];
    //_imageurlView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_imageurlView];
    
    UIImageView *likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH-85, _imageurlView.frame.origin.y + KHEIGHT/3 + 5, 20, 20)];
    likeImage.image = [UIImage imageNamed:@"like.png"];
    [self.contentView addSubview:likeImage];
    
    self.favLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH-60, _imageurlView.frame.origin.y + KHEIGHT/3 + 5, 50, 20)];
    //_favLabel.backgroundColor = [UIColor redColor];
    _favLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_favLabel];
}

- (void)setLuo:(LuoWang *)luo {
    
    _luo = luo;
    _numberLabel.text = luo.number;
    _nameLabel.text = luo.name;
    _tagsLabel.text = luo.tags;
    _favLabel.text = luo.fav;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
