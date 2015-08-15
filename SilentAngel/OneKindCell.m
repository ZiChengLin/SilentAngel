//
//  OneKindCell.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/29.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "OneKindCell.h"
#import "Common.h"
#import "OneKind.h"
#import "UIImageView+WebCache.h"

@implementation OneKindCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    self.bgCellView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, KWIDTH-20, KWIDTH/2+10)];
    _bgCellView.image = [UIImage imageNamed:@"cellbg"];
    [self.contentView addSubview:_bgCellView];
    
    self.ophotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, KWIDTH/2-20, KWIDTH/2-20)];
    //_ophotoImageView.backgroundColor = [UIColor orangeColor];
    //_ophotoImageView.layer.masksToBounds = YES;
    //_ophotoImageView.layer.cornerRadius = 5;
    [_bgCellView addSubview:_ophotoImageView];
    
    self.mnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/2-10, 15, KWIDTH/2-20, 30)];
    //_mnameLabel.backgroundColor = [UIColor yellowColor];
    _mnameLabel.textAlignment = NSTextAlignmentCenter;
    _mnameLabel.font = [UIFont systemFontOfSize:16];
    [_bgCellView addSubview:_mnameLabel];
    
    self.mdescLabel = [[ZCLabel alloc] initWithFrame:CGRectMake(KWIDTH/2-10, _mnameLabel.frame.origin.y + 30, KWIDTH/2-20, KWIDTH/2-20-30)];
    //_mdescLabel.backgroundColor = [UIColor orangeColor];
    [_mdescLabel setVerticalAlignment:VerticalAlignmentTop];
    _mdescLabel.textAlignment = NSTextAlignmentCenter;
    _mdescLabel.numberOfLines = 0;
    _mdescLabel.font = [UIFont systemFontOfSize:12];
    [_bgCellView addSubview:_mdescLabel];
    
    UIImageView *m = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH-45, 5, 20, 20)];
    m.image = [UIImage imageNamed:@"music.png"];
    [_bgCellView addSubview:m];
}

- (void)setOne:(OneKind *)one {
    
    _one = one;
    _mnameLabel.text = one.mname;
    _mdescLabel.text = one.mdesc;
    
    /*
    CGRect mdescRect = _mdescLabel.frame;
    mdescRect.size.height = [[self class] cellContentHeight:one] - 50;
    _mdescLabel.frame = mdescRect;
    */
    
    /*
    CGRect bgCellViewRect = _bgCellView.frame;
    bgCellViewRect.size.height = KWIDTH/2+10;
    _bgCellView.frame = bgCellViewRect;
     */
}

+ (CGFloat)cellContentHeight:(OneKind *)content {
    
    CGFloat unChangeHeight = 50;
    CGRect rect = [content.mdesc boundingRectWithSize:CGSizeMake(KWIDTH/2-10, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
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
