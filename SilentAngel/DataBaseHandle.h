//
//  DataBaseHandle.h
//  SilentAngel
//
//  Created by 林梓成 on 15/8/8.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneKindList.h"

@interface DataBaseHandle : NSObject

+ (DataBaseHandle *)shareInstance;

- (void)initDataBase;

- (void)addNewGeQu:(OneKindList *)gequ andIndex:(NSString *)indexString;
- (void)deleteGeQu:(NSString *)theID;
- (NSString *)selectIndexString:(NSString *)theID;   // 
- (NSArray *)selectAllGeQu;
- (BOOL)isLikeGeQuWithID:(NSString *)ID;

@end
