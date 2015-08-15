//
//  LifeViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/28.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LifeViewController.h"
#import "DanceViewController.h"
#import "LifeContentViewController.h"

#import "LuoWang.h"
#import "LuoWangCell.h"
#import "DanQu.h"
#import "DanQuCell.h"

#import "API.h"
#import "Common.h"
#import "InstanceHandle.h"
#import "AFNetworking.h"
#import "HLAudioStreamer.h"
#import "UIImageView+WebCache.h"

@interface LifeViewController ()<UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    DanQuCell *cell;
    DanceViewController *danceViewController;
}
@property (nonatomic, strong) UIView      *wrapView;
@property (nonatomic, strong) UIView      *rigWrapView;
@property (nonatomic, strong) UIImageView *hamburger;
@property (nonatomic)         BOOL        isShowMenu;

@property (nonatomic, strong) UIWebView      *webView;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *luoWangArray;

@property (nonatomic, strong) NSMutableArray *danquArray;
@property (nonatomic, strong) NSMutableArray *playBtnArray;

@end

@implementation LifeViewController

- (NSMutableArray *)luoWangArray {
    
    if (_luoWangArray == nil) {
        
        _luoWangArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _luoWangArray;
}

- (NSMutableArray *)playBtnArray {
    
    if (_playBtnArray == nil) {
        
        _playBtnArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _playBtnArray;
}

- (NSMutableArray *)danquArray {
    
    if (_danquArray == nil) {
        
        _danquArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _danquArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"心适时光－发现最美音乐";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self initLeftBarBtn];
    [self initRightBarBtn];
    //[self initWebView];
    //[self initLuoWangData];
    [self initDanQuData];
    
    self.isShowMenu = NO;
}

- (void)initWebView {
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-64-49)];
    NSString *urlPath = IDEATAPI;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]];
    
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
}

- (void)initLuoWangData {
    
    NSString *urlPath = LUOWAPI;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block LifeViewController *lv = self;
    [manager GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dict[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        
        for (NSDictionary *dic in itemsArr) {
            
            LuoWang *luo = [[LuoWang alloc] init];
            [luo setValuesForKeysWithDictionary:dic];
            [lv.luoWangArray addObject:luo];
        }
        
        [lv initTableView];
        [lv addDanceViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载错误--%@", error);
    }];
    
}

- (void)initDanQuData {
    
    NSString *urlPath = DANQUAPI2;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block LifeViewController *lv = self;
    [manager GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = operation.responseData;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dict[@"data"];
        
        NSArray *itemsArr = dataDic[@"items"];
        for (NSDictionary *dic in itemsArr) {
            
            DanQu *danqu = [[DanQu alloc] init];
            [danqu setValuesForKeysWithDictionary:dic];
            [lv.danquArray addObject:danqu];
        }
        
        InstanceHandle *instance = [InstanceHandle shareInstance];
        instance.songListArray = lv.danquArray;
        
        [lv initTableView];
        [lv addDanceViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载错误--%@", error);
    }];
    
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-49-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //_tableView.bounces = NO;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)initLeftBarBtn {
    
    // UIBarButtonItem的initWithCustomView:方法会对内部控件有特殊约束
    // 直接将hamburger添加上去会无法实现滚动效果
    // 解决办法：将hamburger包装在一个view里面
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hamburgerClick)];
    self.wrapView = wrapView;
    [wrapView addGestureRecognizer:tap];
    
    UIImageView *hamburger = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu"]];
    self.hamburger = hamburger;
    [wrapView addSubview:hamburger];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
}

- (void)initRightBarBtn {
    
    UIView *rigWrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rigWrapViewClick)];
    [rigWrapView addGestureRecognizer:tap];
    self.rigWrapView = rigWrapView;
    UIImageView *rigBarBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [rigWrapView addSubview:rigBarBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rigWrapView];
}

- (void)addDanceViewController {
    
    danceViewController = [[DanceViewController alloc] init];
    danceViewController.view.frame = CGRectMake(0, -KHEIGHT, KWIDTH, KHEIGHT);
    [self.view addSubview:danceViewController.view];
}

- (void)hamburgerClick {
    
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        if (self.isShowMenu == NO) {
            self.wrapView.transform = CGAffineTransformMakeRotation(M_PI/2);
            self.rigWrapView.hidden = YES;
            
            CGRect danceViewRect = danceViewController.view.frame;
            danceViewRect.origin.y = 0;
            danceViewController.view.frame = danceViewRect;
            
        } else {
            self.wrapView.transform = CGAffineTransformMakeRotation(0);     // 呵呵！一个0解决问题
            self.rigWrapView.hidden = NO;
            CGRect danceViewRect = danceViewController.view.frame;
            danceViewRect.origin.y = -KHEIGHT;
            danceViewController.view.frame = danceViewRect;
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
    _isShowMenu = !_isShowMenu;
}

- (void)rigWrapViewClick {
    
    
}

#pragma mark -- talbeView的代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.danquArray.count;
    
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     static NSString *cellIdentifier = @"danqucell";
     LuoWangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     if (nil == cell) {
     
     cell = [[LuoWangCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     }
     
     LuoWang *luo = self.luoWangArray[indexPath.row];
     cell.luo = luo;
     [cell.imageurlView sd_setImageWithURL:[NSURL URLWithString:luo.imageurl] placeholderImage:[UIImage imageNamed:@"missing_article"]];
     
     return cell;
     */
    
    //static NSString *cellIdentifier = @"danqucell";
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld", indexPath.section, indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell) {
        
        cell = [[DanQuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /*
        [cell.playPauseBtn setImage:[[UIImage imageNamed:@"dpause.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [cell.playPauseBtn setImage:[[UIImage imageNamed:@"dplay.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        
        [cell.playPauseBtn addTarget:self action:@selector(playPauseAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.playPauseBtn.tag = 10000+indexPath.row;
        cell.playPauseBtn.selected = NO;
         */
    }
    
    DanQu *danqu = self.danquArray[indexPath.row];
    cell.danqu = danqu;
    [cell.imageurlView sd_setImageWithURL:[NSURL URLWithString:danqu.imageurl] placeholderImage:[UIImage imageNamed:@"missing_article"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [DanQuCell cellContentHeight:self.danquArray[indexPath.row]] + 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LifeContentViewController *lifeContentViewController = [[LifeContentViewController alloc] init];
    
    DanQu *danqu = self.danquArray[indexPath.row];
    lifeContentViewController.imageurlString = danqu.imageurl;
    lifeContentViewController.albumString = danqu.album;
    lifeContentViewController.artistString = danqu.artist;
    lifeContentViewController.playurl_low = danqu.playurl_low;
    lifeContentViewController.songIndex = (int)(indexPath.row);
    
    [self.navigationController pushViewController:lifeContentViewController animated:YES];
}

- (void)playPauseAction:(UIButton *)sender {
    
    /*
    NSInteger index = [self.tableView indexPathForCell:((UITableViewCell*)[[sender superview]superview])].row;
    DanQu *danqu = self.danquArray[index];
    
    if (!sender.selected) {
        
        [[HLAudioStreamer shareStreamer] setAudioMediaDataWithURL:danqu.playurl_low];
        [[HLAudioStreamer shareStreamer] play];
        
        sender.selected = YES;
        
    } else {
        
        [[HLAudioStreamer shareStreamer] stop];
        
        sender.selected = NO;
    }
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
