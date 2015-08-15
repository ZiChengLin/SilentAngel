//
//  DataBaseHandle.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/8.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DataBaseHandle.h"
#import "FMDatabase.h"

@interface DataBaseHandle ()
{
    FMDatabase *_fmDB;
}
@end

@implementation DataBaseHandle

+ (DataBaseHandle *)shareInstance {
    
    static DataBaseHandle *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[DataBaseHandle alloc]init];
        [instance initDataBase];
    });
    return instance;
}

- (void)initDataBase {
    
    if (_fmDB != nil) {
        
        return;
    }
    
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"lin.sqlite"];
    NSLog(@"%@", documentsPath);
    
    if (!_fmDB) {
        
        // 实例化FMDatabase对象
        _fmDB = [FMDatabase databaseWithPath:filePath];
    }
    // 打开数据库
    [_fmDB open];
    
    // 初始化歌曲的数据表
    [_fmDB executeUpdate:@"CREATE TABLE ZiChengTable(id INTEGER PRIMARY KEY AUTOINCREMENT, indexString TEXT, theID TEXT, filename TEXT, songer TEXT, songname TEXT, songphoto TEXT, time TEXT)"];
    
    [_fmDB close];
}

- (void)addNewGeQu:(OneKindList *)gequ andIndex:(NSString *)indexString {
    
    [_fmDB open];
    [_fmDB executeUpdate:@"INSERT INTO ZiChengTable(indexString,theID,filename,songer,songname,songphoto,time)VALUES(?,?,?,?,?,?,?)", indexString, gequ.theID, gequ.filename, gequ.songer, gequ.songname, gequ.songphoto, gequ.time];
    [_fmDB close];
}

- (void)deleteGeQu:(NSString *)theID {
    
    [_fmDB open];
    [_fmDB executeUpdate:@"DELETE FROM ZiChengTable WHERE theID = ?",theID];   // 删除数据需注意
    [_fmDB close];
}

- (NSString *)selectIndexString:(NSString *)theID {
    
    [_fmDB open];
    FMResultSet *set = [_fmDB executeQueryWithFormat:@"SELECT indexString FROM ZiChengTable WHERE theID = %@;", theID];
    NSString *_indexString = nil;
    while (set.next) {
        
        _indexString = [set stringForColumnIndex:0];
    }
    
    [_fmDB close];
    return _indexString;
}

- (NSArray *)selectAllGeQu {
    
    [_fmDB open];
    
    FMResultSet *res = [_fmDB executeQuery:@"SELECT * FROM ZiChengTable"];
    
    NSMutableArray *allData = [NSMutableArray array];
    while (res.next) {
        
        NSString *_indexString = [res stringForColumnIndex:1];
        NSString *_theID = [res stringForColumnIndex:2];
        NSString *_filename = [res stringForColumnIndex:3];
        NSString *_songer = [res stringForColumnIndex:4];
        NSString *_songname = [res stringForColumnIndex:5];
        NSString *_songphoto = [res stringForColumnIndex:6];
        NSString *_time = [res stringForColumnIndex:7];
        
        OneKindList *oneKindList = [[OneKindList alloc] init];
        oneKindList.indexString = _indexString;
        oneKindList.theID = _theID;
        oneKindList.filename = _filename;
        oneKindList.songer = _songer;
        oneKindList.songname = _songname;
        oneKindList.songphoto = _songphoto;
        oneKindList.time = _time;
        
        [allData addObject:oneKindList];
    }
    
    [_fmDB close];

    return allData;
}

- (BOOL)isLikeGeQuWithID:(NSString *)ID {
    
    [_fmDB open];
    FMResultSet *set = [_fmDB executeQueryWithFormat:@"SELECT * FROM ZiChengTable WHERE theID = %@;", ID];
    
    while (set.next)
        return YES;
    
    return NO;
}


























@end
