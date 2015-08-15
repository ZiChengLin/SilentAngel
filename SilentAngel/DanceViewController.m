//
//  DanceViewController.m
//  CeEr
//
//  Created by 林梓成 on 15/7/26.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "DanceViewController.h"
#import "CollectionViewController.h"
#import "FeedBackViewController.h"
#import "SceneViewController.h"
#import "Common.h"
#import "DanceCell.h"

#import "SDImageCache.h"

@interface DanceViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIAlertView *_alertView;
}

@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation DanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(getBack:)];
    
    UIImage *image = [[UIImage imageNamed:@"clear"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clear:)];
    
    [self initTableView];
    [self initSignLabel];
}

- (void)getBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)clear:(id)sender {
    
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    //NSLog(@"------%f", tmpSize/1000000);
    
    if (tmpSize/1000000 >= 1) {
        
        NSString *string = [NSString stringWithFormat:@"喵！清除了%.1fM缓存哦=_=", tmpSize/1000000];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"心适" message:string delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        [[SDImageCache sharedImageCache] clearDisk];
        
    } else if (tmpSize/1000000 > 0 && tmpSize/1000000 < 1){
        
        NSString *string = [NSString stringWithFormat:@"喵！清除了%.1fK缓存哦=_=", tmpSize/1000000 * 1024];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"心适" message:string delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        [[SDImageCache sharedImageCache] clearDisk];
        
    } else {
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"心适" message:@"喵！缓存已经被清干净了哦=_=" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
    }
}

- (void)removeAlertView {
    
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)initTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, KWIDTH, KHEIGHT-49-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)initSignLabel {
    
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/2-50, KHEIGHT-64-49, 100, 20)];
    //signLabel.backgroundColor = [UIColor orangeColor];
    signLabel.text = @"Version 1.0.0";
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.textColor = [UIColor grayColor];
    signLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:signLabel];
    
    UILabel *privateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/2-50, signLabel.frame.origin.y+20, 100, 20)];
    //privateLabel.backgroundColor = [UIColor brownColor];
    privateLabel.text = @"小城 出品";
    privateLabel.textAlignment = NSTextAlignmentCenter;
    privateLabel.textColor = [UIColor grayColor];
    privateLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:privateLabel];
}

#pragma mark -- talbeView的代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"dcell";
    DanceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        
        cell = [[DanceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        
        cell.danceLabel.text = @"我的喜欢";
    } else if (indexPath.row == 1) {
        cell.danceLabel.text = @"关于心适";
    } else
        cell.danceLabel.text = @"意见反馈";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KHEIGHT/10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        CollectionViewController *collectionViewController = [[CollectionViewController alloc] init];
        [self.navigationController pushViewController:collectionViewController animated:YES];
        
    } else if (indexPath.row == 1) {
        
        SceneViewController *sceneViewController = [[SceneViewController alloc] init];
        [self.navigationController pushViewController:sceneViewController animated:YES];
        
    } else {
        
        FeedBackViewController *feedbackViewController = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedbackViewController animated:YES];
    }
    
}

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
