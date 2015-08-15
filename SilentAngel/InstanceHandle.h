//
//  InstanceHandle.h
//  SilentAngel
//
//  Created by 林梓成 on 15/8/1.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstanceHandle : NSObject

@property (nonatomic, strong) NSMutableArray *songListArray;
@property (nonatomic, strong) NSMutableArray *danquListArray;

+ (InstanceHandle *)shareInstance;

@end
