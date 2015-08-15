//
//  MusicViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/28.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MusicViewController.h"
#import "DanceViewController.h"
#import "MusicScrollViewController.h"
#import "MusicContentViewController.h"

#import "OneKind.h"
#import "CycleScrollViewCell.h"
#import "CycleScrollView.h"
#import "OneKindCell.h"

#import "API.h"
#import "Common.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface MusicViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UIImageView         *bgView;
    DanceViewController *danceViewController;
}
@property (nonatomic, strong) UIView      *wrapView;
@property (nonatomic, strong) UIView      *rigWrapView;
@property (nonatomic, strong) UIImageView *hamburger;
@property (nonatomic)         BOOL        isShowMenu;
@property (nonatomic)         NSInteger   i;
@property (nonatomic, strong) NSString    *index;

@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *oneKindArray;
@property (nonatomic, strong) NSMutableArray  *topOneKindArray;
@property (nonatomic, strong) CycleScrollView *mainScorllView;
@property (nonatomic, strong) UIImageView     *mphotoImageView;
@property (nonatomic, strong) UILabel         *mnameLabel;
@property (nonatomic, strong) UILabel         *mdescLabel;

@end

@implementation MusicViewController

- (NSMutableArray *)oneKindArray {
    
    if (_oneKindArray == nil) {
        
        _oneKindArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _oneKindArray;
}

- (NSMutableArray *)topOneKindArray {
    
    if (_topOneKindArray == nil) {
        
        _topOneKindArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _topOneKindArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"心适时光－发现最美音乐";

    self.i = 1;
    self.index = [NSString stringWithFormat:@"%ld", (long)self.i];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn:)];
    
    //[self initLeftBarBtn];
    //[self initRightBarBtn];
    [self initMusicData:self.index];
    [self initTableView];
    [self loadingMore];
    //[self addDanceViewController];
    self.isShowMenu = NO;
}

- (void)leftBtn:(id)sender {
    
    danceViewController = [[DanceViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:danceViewController];
    //navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;  // 模态视图样式
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
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

- (void)initMusicData:(NSString *)page {
    
    NSString *tempStr = @"&pageNo=Lin&pageSize=10";
    NSString *pageStr = [tempStr stringByReplacingOccurrencesOfString:@"Lin" withString:page];
    
    NSString *bodyStr = pageStr;
    
    NSURL *url = [NSURL URLWithString:KONEKINDAPI];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *data = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    __block MusicViewController *mv = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil) {
            
            return;
        }
        
        NSArray *rArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in rArray) {
            
            OneKind *one = [[OneKind alloc] init];
            [one setValuesForKeysWithDictionary:dic];
            [mv.oneKindArray addObject:one];
        }
        
        [mv.tableView reloadData];
       
    }];
}

- (void)addDanceViewController {
    
    danceViewController = [[DanceViewController alloc] init];
    danceViewController.view.frame = CGRectMake(0, -KHEIGHT, KWIDTH, KHEIGHT);
    [self.view addSubview:danceViewController.view];
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-49-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.bounces = NO;   // 需要把反弹打开不然分区头上去了就下不来了
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

- (void)loadingMore {
    
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self performSelector:@selector(refreshMore) withObject:nil afterDelay:0.5f];
    }];
    [self.tableView.header beginRefreshing];
    
    //上拉加载
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.footer beginRefreshing];
        [self performSelector:@selector(loadedMore) withObject:nil afterDelay:1.0f];
    }];
    
}

- (void)refreshMore {
    
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}

- (void)loadedMore {
    
    self.i++;
    NSString *index = [NSString stringWithFormat:@"%ld", (long)self.i];
    [self initMusicData:index];
    
    [self.tableView.footer endRefreshing];
}

- (void)hamburgerClick {
    
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        if (self.isShowMenu == NO) {
            
            self.wrapView.transform = CGAffineTransformMakeRotation(M_PI/2);
            self.rigWrapView.hidden = YES;
            
            //CGRect danceViewRect = danceViewController.view.frame;
            //danceViewRect.origin.y = 0;
            //danceViewController.view.frame = danceViewRect;
            
        } else {
            self.wrapView.transform = CGAffineTransformMakeRotation(0);     // 呵呵！一个0解决问题
            self.rigWrapView.hidden = NO;
            
            //CGRect danceViewRect = danceViewController.view.frame;
            //danceViewRect.origin.y = -KHEIGHT;
            //danceViewController.view.frame = danceViewRect;
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
    _isShowMenu = !_isShowMenu;
}

- (void)rigWrapViewClick {
    
    
}

#pragma mark -- talbeView的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.oneKindArray.count;
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ccell";
    OneKindCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[OneKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    OneKind *one = self.oneKindArray[indexPath.row];
    cell.one = one;
    [cell.ophotoImageView sd_setImageWithURL:[NSURL URLWithString:one.ophoto] placeholderImage:[UIImage imageNamed:@"missing_article"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return KWIDTH/2+20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicContentViewController *musicContentViewController = [[MusicContentViewController alloc] init];
    
    OneKind *one = self.oneKindArray[indexPath.row];
    musicContentViewController.mnameString = one.mname;
    musicContentViewController.mdescString = one.mdesc;
    musicContentViewController.ophotoString = one.ophoto;
    musicContentViewController.indexString = [NSString stringWithFormat:@"%ld", (indexPath.row)];
    
    [self.navigationController pushViewController:musicContentViewController animated:YES];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return KHEIGHT/3;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSLog(@"%ld",self.oneKindArray.count);
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    for (int i = 0; i < self.oneKindArray.count; ++i) {
        
        self.mphotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT/3)];
        _mphotoImageView.userInteractionEnabled = YES;
        
        OneKind *one = self.oneKindArray[i];
        [_mphotoImageView sd_setImageWithURL:[NSURL URLWithString:one.mphoto] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        [viewsArray addObject:_mphotoImageView];
        
        /*
         self.mnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, KHEIGHT/9, KWIDTH-80, 30)];
         //_mnameLabel.backgroundColor = [UIColor orangeColor];
         _mnameLabel.textColor = [UIColor blackColor];
         _mnameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
         _mnameLabel.text = one.mname;
         [_mphotoImageView addSubview:_mnameLabel];
         
         self.mdescLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _mnameLabel.frame.origin.y + 30, KWIDTH-40, KHEIGHT/6)];
         //_mdescLabel.backgroundColor = [UIColor yellowColor];
         _mdescLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
         _mdescLabel.textColor = [UIColor blackColor];
         _mdescLabel.numberOfLines = 0;
         _mdescLabel.text = one.mdesc;
         [_mphotoImageView addSubview:_mdescLabel];

         */
    }
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT/3) animationDuration:4.0];
    _mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    _mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    _mainScorllView.totalPagesCount = ^NSInteger(void){
        return 10;
    };
    
    __block MusicViewController *mc = self;
    _mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        
        //NSLog(@"点击了第%ld个",(long)pageIndex);
        
        MusicContentViewController *musicContentViewController = [[MusicContentViewController alloc] init];
        
        OneKind *one = mc.oneKindArray[pageIndex];
        musicContentViewController.mnameString = one.mname;
        musicContentViewController.mdescString = one.mdesc;
        musicContentViewController.ophotoString = one.ophoto;
        musicContentViewController.indexString = [NSString stringWithFormat:@"%ld", (pageIndex)];
        
        [mc.navigationController pushViewController:musicContentViewController animated:YES];
        
    };
    
    _tableView.delegate = self;
    
    return _mainScorllView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = KHEIGHT/3;
    
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
