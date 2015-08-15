//
//  CollectionViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/8.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "CollectionViewController.h"
#import "MusicPlayViewController.h"
#import "CollectionCell.h"
#import "OneKindList.h"
#import "DataBaseHandle.h"
#import "Common.h"

@interface CollectionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView    *tableView;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LIKE";
    
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(getBack:)];

    [self initTableView];
    [CollectionViewController setExtraCellLineHidden:self.tableView];
}

- (void)getBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //self.tableView.bounces = NO;
    //_tableView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_tableView];
}

#pragma mark -- talbeView的代理方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[DataBaseHandle shareInstance] selectAllGeQu].count;
}


-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"likecell";
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[CollectionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    OneKindList *oneKindList = [[DataBaseHandle shareInstance]selectAllGeQu][indexPath.row];
    cell.oneKindList = oneKindList;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KHEIGHT/8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OneKindList *oneKindList = [[DataBaseHandle shareInstance]selectAllGeQu][indexPath.row];
    
    MusicPlayViewController *musicPlayViewController = [[MusicPlayViewController alloc] init];
    musicPlayViewController.songphotoString = oneKindList.songphoto;
    musicPlayViewController.songerString = oneKindList.songer;
    musicPlayViewController.songnameString = oneKindList.songname;
    musicPlayViewController.filenameString = oneKindList.filename;
    musicPlayViewController.songtimeString = oneKindList.time;

    NSString *songIndex = [[DataBaseHandle shareInstance]selectIndexString:oneKindList.theID];
    musicPlayViewController.songIndex = [songIndex intValue];
    musicPlayViewController.isCollection = @"YES";
    
    [self.navigationController pushViewController:musicPlayViewController animated:YES];
}

#pragma mark - 编辑的代理方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        OneKindList *oneKindList = [[DataBaseHandle shareInstance]selectAllGeQu][indexPath.row];
        
        [[DataBaseHandle shareInstance] deleteGeQu:oneKindList.theID];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView endUpdates];
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
