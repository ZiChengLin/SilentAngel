//
//  ZCLabel.h
//  SouthCity
//
//  Created by 林梓成 on 15/7/16.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0,  // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
    
} VerticalAlignment;

@interface ZCLabel : UILabel
{
    @private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
