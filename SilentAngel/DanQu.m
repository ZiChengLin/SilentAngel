//
//  DanQu.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DanQu.h"

@implementation DanQu

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        
        self.ide = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"musician_id"]) {
        
        self.musician_id = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"comm"]) {
        
        self.comm = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"fav"]) {
        
        self.fav = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"tags"]) {
        
        NSArray *tagsArr = (NSArray *)value;
        NSMutableArray *tag_nameArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSDictionary *dic in tagsArr) {
            
            [tag_nameArray addObject:dic[@"tag_name"]];
        }
        
        self.tag_name = [tag_nameArray componentsJoinedByString:@"、"];
    }
    
}


@end
