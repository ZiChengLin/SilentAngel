//
//  MusicScrollViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/29.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MusicScrollViewController.h"
#import "MusicViewController.h"
#import "MusicContentViewController.h"
#import "CycleScrollView.h"
#import "API.h"
#import "Common.h"
#import "OneKind.h"
#import "UIImageView+WebCache.h"

@interface MusicScrollViewController ()

@property (nonatomic, strong) CycleScrollView *mainScorllView;
@property (nonatomic, strong) NSMutableArray  *oneKindArray;
@property (nonatomic)         NSInteger   i;

@property (nonatomic, strong) UILabel         *mnameLabel;
@property (nonatomic, strong) UILabel         *mdescLabel;

@end

@implementation MusicScrollViewController

- (NSMutableArray *)oneKindArray {
    
    if (_oneKindArray == nil) {
        
        _oneKindArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _oneKindArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.i = arc4random()%8;
    NSString *index = [NSString stringWithFormat:@"%ld", (long)self.i];
    [self initMusicData:index];
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
    
    __block MusicScrollViewController *mv = self;
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
        
        [self initUpScrollView];  // 请求完数据后执行需要用到数据的方法 相当于uitableview的reloadData 让cellForRow重走一遍
    }];
    
}

- (void)initUpScrollView {
    
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    for (int i = 0; i < 10; ++i) {
        
        self.mphotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT/3)];
        _mphotoImageView.userInteractionEnabled = YES;
        
        OneKind *one = self.oneKindArray[i];
        [_mphotoImageView sd_setImageWithURL:[NSURL URLWithString:one.mphoto] placeholderImage:[UIImage imageNamed:@"missing_article"]];
        [viewsArray addObject:_mphotoImageView];
        
        /*
        self.mnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, KHEIGHT/9, KWIDTH-80, 30)];
        //_mnameLabel.backgroundColor = [UIColor orangeColor];
        _mnameLabel.textColor = [UIColor whiteColor];
        _mnameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _mnameLabel.text = one.mname;
        [_mphotoImageView addSubview:_mnameLabel];
        
        self.mdescLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _mnameLabel.frame.origin.y + 30, KWIDTH-40, KHEIGHT/6)];
        //_mdescLabel.backgroundColor = [UIColor yellowColor];
        _mdescLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        _mdescLabel.textColor = [UIColor whiteColor];
        _mdescLabel.numberOfLines = 0;
        _mdescLabel.text = one.mdesc;
        [_mphotoImageView addSubview:_mdescLabel];
        */
    }
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT/3) animationDuration:4.0];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return 10;
    };
    
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        
        NSLog(@"点击了第%ld个",(long)pageIndex);
    };
    [self.view addSubview:self.mainScorllView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
