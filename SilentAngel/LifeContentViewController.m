//
//  LifeContentViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/8/2.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "LifeContentViewController.h"

#import "Common.h"
#import "DanQu.h"
#import "InstanceHandle.h"
#import "HLAudioStreamer.h"
#import "UIImageView+WebCache.h"

@interface LifeContentViewController ()<HLAudioStreamerDelegate>
{
    UIVisualEffectView *bgVisualEffectView;
    UIButton           *playButton;
}

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *dickImageView;
@property (nonatomic, strong) UIImageView *songphotoImageView;

@property (nonatomic, strong) UILabel     *songnameLabel;
@property (nonatomic, strong) UILabel     *songerLabel;

@end

@implementation LifeContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SINGLE";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(getBack:)];
    
    [self createBackgroundView];
    [self createPlayControlButton];
    [self createLabelView];
    [self createRotateDickAndSongphoto];
    [self reloadMusicPlayerView];
    
    // 判断当前播放的音乐和通过URL请求的是否同一个 如不是则切歌
    if (![[HLAudioStreamer shareStreamer] isPlayingCurrentAudioWithURL:self.playurl_low]) {
        
        [[HLAudioStreamer shareStreamer] setAudioMediaDataWithURL:self.playurl_low];
        [[HLAudioStreamer shareStreamer] play];
    }
    
    // 修复播放节目暂停返回上一界面再次进来时不播放的情况
    if ([[HLAudioStreamer shareStreamer] isPlayingCurrentAudioWithURL:self.playurl_low] && playButton.selected == NO) {
        
        [[HLAudioStreamer shareStreamer] play];
    }

    
    [HLAudioStreamer shareStreamer].delegate = self;
}

- (void)getBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadMusicPlayerView {
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.imageurlString]];
    
    [self.songphotoImageView sd_setImageWithURL:[NSURL URLWithString:self.imageurlString] placeholderImage:[UIImage imageNamed:@"missing_music"]];
    
    self.songnameLabel.text = self.albumString;
    self.songerLabel.text = self.artistString;
    
    self.dickImageView.transform = CGAffineTransformMakeRotation(0);             // dick角度为0
    
    // 加载动画
    [UIView animateWithDuration:2.0 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        CGRect songphotoRect = self.songphotoImageView.frame;
        songphotoRect.origin.x = KWIDTH/6;
        self.songphotoImageView.frame = songphotoRect;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    [UIView animateWithDuration:2.0 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        CGRect dickImageRect = self.dickImageView.frame;
        dickImageRect.origin.x = KWIDTH*5/6 - KWIDTH/2;
        self.dickImageView.frame = dickImageRect;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)createBackgroundView {
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_bgImageView setUserInteractionEnabled:YES];
    [self.view addSubview:_bgImageView];
    
    UIVisualEffectView *bgVisualEffect = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    bgVisualEffect.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT-150);
    [self.bgImageView addSubview:bgVisualEffect];
    
    bgVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    bgVisualEffectView.frame = CGRectMake(0, KHEIGHT-150-49-64, KWIDTH, 150);
    bgVisualEffectView.alpha = 0.9;
    [self.bgImageView addSubview:bgVisualEffectView];
}

- (void)createPlayControlButton {
    
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(0, 0, 20, 20);
    [playButton setImage:[UIImage imageNamed:@"zanting.png"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(playPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    playButton.center = CGPointMake(self.view.center.x, KHEIGHT-150);
    [self.bgImageView addSubview:playButton];
    
    /*
    UIButton* nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(0, 0, 20, 20);
    [nextButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    nextButton.center = CGPointMake(KWIDTH*3/4, KHEIGHT-150);
    [nextButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:nextButton];
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 0, 20, 20);
    [previousButton setImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
    previousButton.center = CGPointMake(KWIDTH/4, KHEIGHT-150);
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:previousButton];
    */
}

- (void)createLabelView {
    
    self.songnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, KWIDTH, 30)];
    _songnameLabel.textAlignment = NSTextAlignmentCenter;
    //_songnameLabel.backgroundColor = [UIColor yellowColor];
    [bgVisualEffectView addSubview:_songnameLabel];
    
    self.songerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, KWIDTH, 20)];
    //_songerLabel.backgroundColor = [UIColor brownColor];
    _songerLabel.textAlignment = NSTextAlignmentCenter;
    _songerLabel.font = [UIFont systemFontOfSize:12];
    [bgVisualEffectView addSubview:_songerLabel];
}

- (void)createRotateDickAndSongphoto {
    
    self.dickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH/2 - (KWIDTH/4), 64, KWIDTH/2, KWIDTH/2)];
    _dickImageView.layer.masksToBounds = YES;
    _dickImageView.layer.cornerRadius = KWIDTH/4;
    _dickImageView.image = [UIImage imageNamed:@"dick"];
    [self.bgImageView addSubview:_dickImageView];
    
    self.songphotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH/2 - (KWIDTH/4), 64, KWIDTH/2, KWIDTH/2)];
    
    [self.bgImageView addSubview:_songphotoImageView];
}

#pragma -- amrk 点击暂停播放按钮执行的方法
- (void)playPauseAction:(UIButton *)sender {
    
    if (sender.selected) {
        
        sender.selected = NO;
        [[HLAudioStreamer shareStreamer] play];
        
        [UIView animateWithDuration:2.0 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            
            CGRect songphotoRect = self.songphotoImageView.frame;
            songphotoRect.origin.x = KWIDTH/6;
            self.songphotoImageView.frame = songphotoRect;
            
        } completion:^(BOOL finished) {
            
        }];
        
        
        [UIView animateWithDuration:2.0 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            
            CGRect dickImageRect = self.dickImageView.frame;
            dickImageRect.origin.x = KWIDTH*5/6 - KWIDTH/2;
            self.dickImageView.frame = dickImageRect;
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    } else {
        
        sender.selected = YES;
        // 在动画前先把磁盘停掉  不然会发生形变
        self.dickImageView.transform = CGAffineTransformMakeRotation(0);
        
        [[HLAudioStreamer shareStreamer] pause];
        
        [UIView animateWithDuration:1.0 delay:0.2 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            
            CGRect songphotoRect = self.songphotoImageView.frame;
            songphotoRect.origin.x = KWIDTH/2 - KWIDTH/4;
            self.songphotoImageView.frame = songphotoRect;
            
        } completion:^(BOOL finished) {
            
        }];
        
        
        [UIView animateWithDuration:1.0 delay:0.2 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            
            CGRect dickImageRect = self.dickImageView.frame;
            dickImageRect.origin.x = KWIDTH/2 - KWIDTH/4;
            self.dickImageView.frame = dickImageRect;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

//#pragma -- mark 点击下一曲执行的方法
//- (void)nextButtonClicked:(UIButton *)sender {
//    
//    playButton.selected = ![HLAudioStreamer shareStreamer].isPlaying;
//    
//    InstanceHandle *instance = [InstanceHandle shareInstance];
//    
//    // 当播放的是最后一首歌的时候切到第一首
//    if (self.songIndex == instance.danquListArray.count - 1) {
//        
//        _songIndex = 0;
//    } else {
//        _songIndex += 1;
//    }
//    
//    DanQu *danqu = instance.danquListArray[_songIndex];
//    
//    [[HLAudioStreamer shareStreamer] setAudioMediaDataWithURL:danqu.playurl_low];
//    
//    self.imageurlString = danqu.imageurl;
//    self.albumString = danqu.album;
//    self.artistString = danqu.artist;
//    
//    [self reloadMusicPlayerView];
//}
//
//#pragma -- mark 点击前一首执行的方法
//- (void)previousClicked:(UIButton *)sender {
//    
//    InstanceHandle *instance = [InstanceHandle shareInstance];
//    
//    if (self.songIndex == 0) {
//        
//        self.songIndex = (int)(instance.danquListArray.count - 1);
//    } else {
//        self.songIndex -= 1;
//    }
//    
//    DanQu *danqu = instance.danquListArray[_songIndex];
//    
//    [[HLAudioStreamer shareStreamer] setAudioMediaDataWithURL:danqu.playurl_low];
//    
//    self.imageurlString = danqu.imageurl;
//    self.albumString = danqu.album;
//    self.artistString = danqu.artist;
//    
//    [self reloadMusicPlayerView];
//}

#pragma -- mark 播放音乐时会一直调用的方法
-(void)audioStramer:(HLAudioStreamer *)stramer didPlayingWithProgress:(float)progress {
    
    _dickImageView.transform = CGAffineTransformRotate(_dickImageView.transform, M_1_PI/30);
}

#pragma -- mark 音乐播放结束的时候自动调用下一首
- (void)audioStramerDidFinishPlaying:(HLAudioStreamer *)streamer {
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"播放结束");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
