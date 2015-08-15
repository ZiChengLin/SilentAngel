//
//  SceneViewController.m
//  SouthCity
//
//  Created by 林梓成 on 15/7/23.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "SceneViewController.h"
#import "AboutSceneCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface SceneViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation SceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ABOUT";
    
    
    [self initTableView];
    [SceneViewController setExtraCellLineHidden:self.tableView];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -44, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

#pragma mark -- talbeView的代理方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"aboutcell";
    AboutSceneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[AboutSceneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        
        cell.aboutImageView.image = [UIImage imageNamed:@"about"];
    } else
        cell.aboutImageView.image = [UIImage imageNamed:@"statement"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return HEIGHT;
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
