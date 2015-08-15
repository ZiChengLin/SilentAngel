//
//  LuoWang.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LuoWang.h"

@implementation LuoWang

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        
        self.iden = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"comm"]) {
        
        self.comm = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"fav"]) {
        
        self.fav = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"number"]) {
        
        self.number = [NSString stringWithFormat:@"%@", value];
    }
    
}

@end
