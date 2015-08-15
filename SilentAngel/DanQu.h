//
//  DanQu.h
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanQu : NSObject

@property (nonatomic, strong) NSString *ide;
@property (nonatomic, strong) NSString *musician_id;
@property (nonatomic, strong) NSString *album;     // 雨昼
@property (nonatomic, strong) NSString *artist;    // 逆耳
@property (nonatomic, strong) NSString *comm;
@property (nonatomic, strong) NSString *fav;
@property (nonatomic, strong) NSString *imageurl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *playurl_low;
@property (nonatomic, strong) NSString *poster;
@property (nonatomic, strong) NSString *public_date;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *tag_name;   // tags数组
@property (nonatomic, strong) NSString *alias_name; // tags数组

@end
