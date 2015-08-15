//
//  MusicContentCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/30.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MusicContentCell.h"
#import "Common.h"
#import "OneKind.h"

@implementation MusicContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
    self.ophotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH-KWIDTH*2/3)/2, 0, KWIDTH*2/3, KWIDTH*2/3)];
    //_ophotoImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_ophotoImageView];
    
    self.mnameLabel = [[UILabel alloc] initWithFrame:CGRectMake((KWIDTH-KWIDTH*2/3)/2, _ophotoImageView.frame.size.height + 10, KWIDTH*2/3, 40)];
    //_mnameLabel.backgroundColor = [UIColor brownColor];
    _mnameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_mnameLabel];
    
    self.mdescLabel = [[ZCLabel alloc] initWithFrame:CGRectMake((KWIDTH-KWIDTH*2/3)/2, _mnameLabel.frame.origin.y + 50, KWIDTH*2/3, 0)];
    //_mdescLabel.backgroundColor = [UIColor yellowColor];
    _mdescLabel.font = [UIFont systemFontOfSize:14];
    _mdescLabel.numberOfLines = 0;
    _mdescLabel.textAlignment = NSTextAlignmentCenter;
    [_mdescLabel setVerticalAlignment:VerticalAlignmentTop];
    [self addSubview:_mdescLabel];
    
}

- (void)setMdescHeight:(NSString *)mdesc {
    
    CGRect mdescRect = _mdescLabel.frame;
    mdescRect.size.height = [[self class] cellContentHeight:mdesc] - (KWIDTH*2/3 + 50);
    _mdescLabel.frame = mdescRect;
}

+ (CGFloat)cellContentHeight:(NSString *)content {
    
    CGFloat unChangeHeight = KWIDTH*2/3 + 50;
    CGRect rect = [content boundingRectWithSize:CGSizeMake(KWIDTH*2/3, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
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
