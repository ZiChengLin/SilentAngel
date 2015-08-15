//
//  MusicContentViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/30.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MusicContentViewController.h"
#import "MusicPlayViewController.h"

#import "OneKind.h"
#import "OneKindList.h"
#import "MusicContentCell.h"
#import "MusicListCell.h"

#import "API.h"
#import "Common.h"
#import "InstanceHandle.h"
#import "UIImageView+WebCache.h"

@interface MusicContentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *oneKindListArray;

@end

@implementation MusicContentViewController

- (NSMutableArray *)oneKindListArray {
    
    if (_oneKindListArray == nil) {
        
        _oneKindListArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _oneKindListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MUSIC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(getBack:)];
    
    [self initIndexData];
}

- (void)initIndexData {
    
    if ([self.indexString intValue] < 10) {
        
        [self initMusicListData:@"1"];
        
    } else if ([self.indexString intValue] >= 10 && [self.indexString intValue] < 19) {
        
        [self initMusicListData:@"2"];
        int i = [self.indexString intValue];
        i -= 10;
        self.indexString = [NSString stringWithFormat:@"%d", i];
    } else if ([self.indexString intValue] >= 20 && [self.indexString intValue] < 29) {
        
        [self initMusicListData:@"3"];
        int i = [self.indexString intValue];
        i -= 20;
        self.indexString = [NSString stringWithFormat:@"%d", i];
    }else if ([self.indexString intValue] >= 30 && [self.indexString intValue] < 39) {
        
        [self initMusicListData:@"4"];
        int i = [self.indexString intValue];
        i -= 30;
        self.indexString = [NSString stringWithFormat:@"%d", i];
    }else if ([self.indexString intValue] >= 40 && [self.indexString intValue] < 49) {
        
        [self initMusicListData:@"5"];
        int i = [self.indexString intValue];
        i -= 40;
        self.indexString = [NSString stringWithFormat:@"%d", i];
    }else if ([self.indexString intValue] >= 50 && [self.indexString intValue] < 59) {
        
        [self initMusicListData:@"6"];
        int i = [self.indexString intValue];
        i -= 50;
        self.indexString = [NSString stringWithFormat:@"%d", i];
    }else if ([self.indexString intValue] >= 60 && [self.indexString intValue] < 69) {
        
        [self initMusicListData:@"7"];
        int i = [self.indexString intValue];
        i -= 60;
        self.indexString = [NSString stringWithFormat:@"%d", i];
    }else if ([self.indexString intValue] >= 70 && [self.indexString intValue] < 79) {
        
        [self initMusicListData:@"8"];
        int i = [self.indexString intValue];
        i -= 70;
        self.indexString = [NSString stringWithFormat:@"%d", i];
    }
}

- (void)getBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initMusicListData:(NSString *)page {
    
    NSString *tempStr = @"&pageNo=Lin&pageSize=10";
    NSString *pageStr = [tempStr stringByReplacingOccurrencesOfString:@"Lin" withString:page];
    
    NSString *bodyStr = pageStr;
    
    NSURL *url = [NSURL URLWithString:KONEKINDAPI];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *data = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    __block MusicContentViewController *mv = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil) {
            
            return;
        }
        
        NSArray *rArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dic = [rArray objectAtIndex:[mv.indexString integerValue]];  // 根据下标解析某一个字典里面的数组数据
        
            NSArray *listArray = dic[@"list"];
            for (NSDictionary *lDic in listArray) {
                
                OneKindList *one = [[OneKindList alloc] init];
                [one setValuesForKeysWithDictionary:lDic];
                [mv.oneKindListArray addObject:one];
            }
        
        InstanceHandle *instance = [InstanceHandle shareInstance];
        instance.songListArray = mv.oneKindListArray;

        [mv initTableView];
    }];
    
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-64-49) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.bounces = NO;
    //_tableView.separatorInset = UIEdgeInsetsMake(0, 30, 0, 30);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark -- talbeView的代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.oneKindListArray.count + 1;
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"concell";
        MusicContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[MusicContentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.userInteractionEnabled = NO;

        cell.mnameLabel.text = self.mnameString;
        cell.mdescLabel.text = self.mdescString;
        [cell setMdescHeight:self.mdescString];    // 将传过来的内容在cell里面进行自适应操作
        [cell.ophotoImageView sd_setImageWithURL:[NSURL URLWithString:self.ophotoString] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        
        return cell;
    }
    
    static NSString *cellIdentifier = @"contentcell";
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[MusicListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.indexLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    OneKindList *oneList = self.oneKindListArray[indexPath.row - 1];
    cell.oneList = oneList;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        return [MusicContentCell cellContentHeight:self.mdescString] + 30;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicPlayViewController *musicPlayViewController = [[MusicPlayViewController alloc] init];
    
    OneKindList *oneList = self.oneKindListArray[indexPath.row - 1];
    musicPlayViewController.songphotoString = oneList.songphoto;
    musicPlayViewController.songerString = oneList.songer;
    musicPlayViewController.songnameString = oneList.songname;
    musicPlayViewController.filenameString = oneList.filename;
    musicPlayViewController.songtimeString = oneList.time;
    musicPlayViewController.songIndex = (int)(indexPath.row - 1);
    musicPlayViewController.oneKindList = oneList;
    
    [self.navigationController pushViewController:musicPlayViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
