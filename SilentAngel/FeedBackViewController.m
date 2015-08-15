//
//  FeedBackViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/20.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackCell.h"
#import "FeedBackTCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FeedBackViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"FEEDBACK";
    
    [self initTableView];
    [FeedBackViewController setExtraCellLineHidden:self.tableView];
}


- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.tableView.bounces = NO;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //_tableView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_tableView];
}

#pragma mark -- talbeView的代理方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"feedbackcell";
        FeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil == cell) {
            
            cell = [[FeedBackCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        return cell;
    }
    
    
    static NSString *cellIdentifier = @"feedbackTwocell";
    FeedBackTCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[FeedBackTCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 1) {
        
        cell.weiQLabel.text = @"1、搜索微信账号“心适－最美音乐” 2、搜索攻城狮微信账号“南方小城”";
        cell.weiQImageView.image = [UIImage imageNamed:@"wechat.png"];
        
    } else if (indexPath.row == 2) {
        
        cell.weiQLabel.text = @"添加QQ：260220408";
        cell.weiQImageView.image = [UIImage imageNamed:@"QQ.png"];
    }
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return HEIGHT/12;
    } else
        return HEIGHT/10;
}

+ (void)setExtraCellLineHidden:(UITableView *)tableView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
