//
//  DanQuCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DanQuCell.h"
#import "DanQu.h"
#import "Common.h"

@implementation DanQuCell

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
    
    self.musician_idLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 25, 30)];
    //_musician_idLabel.backgroundColor = [UIColor greenColor];
    _musician_idLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_musician_idLabel];
    
    self.tagsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH-(KWIDTH-60), 5, KWIDTH-70, 30)];
    //_tagsLabel.backgroundColor = [UIColor orangeColor];
    _tagsLabel.textAlignment = NSTextAlignmentRight;
    _tagsLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_tagsLabel];
    
    self.imageurlView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, KWIDTH, KHEIGHT*0.4)];
    //_imageurlView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_imageurlView];
    
    /*
    self.playPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playPauseBtn.frame = CGRectMake(10, KHEIGHT*0.4+35+9, 32, 32);
    //_playPauseBtn.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_playPauseBtn];
     */
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, KHEIGHT*0.4+35, KWIDTH-120, 30)];
    //_nameLabel.backgroundColor = [UIColor brownColor];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_nameLabel];
    
    self.public_dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH-80, KHEIGHT*0.4+35, 80, 20)];
    _public_dateLabel.backgroundColor = [UIColor orangeColor];
    _public_dateLabel.font = [UIFont systemFontOfSize:12];
    _public_dateLabel.textAlignment = NSTextAlignmentCenter;
    _public_dateLabel.layer.masksToBounds = YES;
    _public_dateLabel.layer.cornerRadius = 10;
    [self.contentView addSubview:_public_dateLabel];
    
    UIImageView *m = [[UIImageView alloc] initWithFrame:CGRectMake(10, KHEIGHT*0.4+65, 20, 20)];
    m.image = [UIImage imageNamed:@"music.png"];
    [self.contentView addSubview:m];
    
    self.artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, KHEIGHT*0.4+65, KWIDTH-120, 20)];
    //_artistLabel.backgroundColor = [UIColor grayColor];
    _artistLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_artistLabel];
    
    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.artistLabel.frame.origin.y+20, KWIDTH, 0)];
    //_remarkLabel.backgroundColor = [UIColor orangeColor];
    _remarkLabel.numberOfLines = 0;
    _remarkLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_remarkLabel];
    
}

- (void)setDanqu:(DanQu *)danqu {
    
    _danqu = danqu;
    _musician_idLabel.text = danqu.musician_id;
    _tagsLabel.text = danqu.tag_name;
    _nameLabel.text = danqu.name;
    _artistLabel.text = danqu.artist;
    _remarkLabel.text = danqu.remark;
    _public_dateLabel.text = danqu.public_date;
    
    CGRect remarkRect = _remarkLabel.frame;
    remarkRect.size.height = ([[self class] cellContentHeight:danqu] - (KHEIGHT*0.4+90));
    _remarkLabel.frame = remarkRect;
}

+ (CGFloat)cellContentHeight:(DanQu *)danqu {
    
    CGFloat unChangeHeight = KHEIGHT*0.4 + 90;
    CGRect rect = [danqu.remark boundingRectWithSize:CGSizeMake(KWIDTH, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    return rect.size.height + unChangeHeight;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
