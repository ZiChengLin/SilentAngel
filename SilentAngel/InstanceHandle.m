//
//  InstanceHandle.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/1.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "InstanceHandle.h"

@implementation InstanceHandle

static InstanceHandle *handle = nil;

+ (InstanceHandle *)shareInstance {
    
//    if (nil == handle) {
//        
//        handle = [[InstanceHandle alloc] init];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        handle = [[InstanceHandle alloc] init];
    });
    
    return handle;
}


@end
