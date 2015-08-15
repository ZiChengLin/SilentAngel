//
//  OneKindList.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/29.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "OneKindList.h"

@implementation OneKindList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"id"]) {
        
        self.theID = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"time"]) {
        
        self.time = [NSString stringWithFormat:@"%@", value];
    }
}

@end
