//
//  MusicPlayViewController.m
//  SilentAngel
//
//  Created by 林梓成 on 15/7/30.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MusicPlayViewController.h"

#import "Common.h"
#import "OneKindList.h"
#import "InstanceHandle.h"
#import "DataBaseHandle.h"
#import "HLAudioStreamer.h"
#import "UIImageView+WebCache.h"

@interface MusicPlayViewController ()<HLAudioStreamerDelegate>
{
    UIVisualEffectView *bgVisualEffectView;
    UIButton           *playButton;
    UIButton           *loveButton;
    UIAlertView        *_alertView;
}
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *dickImageView;
@property (nonatomic, strong) UIImageView *songphotoImageView;

@property (nonatomic, strong) UILabel     *currentLabel;
@property (nonatomic, strong) UILabel     *surplusLabel;
@property (nonatomic, strong) UILabel     *songnameLabel;
@property (nonatomic, strong) UILabel     *songerLabel;

@property (nonatomic, strong) UISlider    *musicProgress;
@property (nonatomic, retain) UISlider    *volumeSlider;
@property (nonatomic, retain) NSTimer     *time;

@end

@implementation MusicPlayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MUSIC";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(getBack:)];
    
    [self createBackgroundView];
    [self createPlayControlButton];
    [self createMusicProgressView];
    [self createLabelView];
    [self createRotateDickAndSongphoto];
    //self.volumeSlider = [self volumeSlider];
    [self reloadMusicPlayerView];
    
    if (!self.isCollection) {
        
        [self initCollecteBtn];
    }
    
    // 判断当前播放的音乐和通过URL请求的是否同一个 如不是则切歌
    if (![[HLAudioStreamer shareStreamer] isPlayingCurrentAudioWithURL:self.filenameString]) {
        
        [[HLAudioStreamer shareStreamer] setAudioMediaDataWithURL:self.filenameString];
        [[HLAudioStreamer shareStreamer] play];
    }
    
    // 修复播放节目暂停返回上一界面再次进来时不播放的情况
    if ([[HLAudioStreamer shareStreamer] isPlayingCurrentAudioWithURL:self.filenameString] && playButton.selected == NO) {
        
        [[HLAudioStreamer shareStreamer] play];
    }
    
    [HLAudioStreamer shareStreamer].delegate = self;
}

- (void)getBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadMusicPlayerView {
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.songphotoString]];
    
    [self.songphotoImageView sd_setImageWithURL:[NSURL URLWithString:self.songphotoString] placeholderImage:[UIImage imageNamed:@"missing_music"]];
    
    self.songnameLabel.text = self.songnameString;
    self.songerLabel.text = self.songerString;
    
    self.dickImageView.transform = CGAffineTransformMakeRotation(0);             // dick角度为0
    self.musicProgress.maximumValue = [self.songtimeString floatValue] / 1000;   // 秒数
    
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
    
    if (self.isCollection) {
        
        bgVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        bgVisualEffectView.frame = CGRectMake(0, KHEIGHT-150-64, KWIDTH, 150);
        bgVisualEffectView.alpha = 0.9;
        [self.bgImageView addSubview:bgVisualEffectView];
    }
    
    bgVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    bgVisualEffectView.frame = CGRectMake(0, KHEIGHT-150-49-64, KWIDTH, 150);
    bgVisualEffectView.alpha = 0.9;
    [self.bgImageView addSubview:bgVisualEffectView];
    
}

- (void)initCollecteBtn {
    
    loveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loveButton.frame = CGRectMake(KWIDTH-30, 10, 20, 20);
    
    if ([[DataBaseHandle shareInstance] isLikeGeQuWithID:self.oneKindList.theID]) {
        
        UIImage *loveImage = [[UIImage imageNamed:@"love.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [loveButton setImage:loveImage forState:UIControlStateNormal];
        [loveButton addTarget:self action:@selector(doLove) forControlEvents:UIControlEventTouchUpInside];
        [bgVisualEffectView addSubview:loveButton];
        
    } else {
        
        UIImage *loveImage = [[UIImage imageNamed:@"loveg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [loveButton setImage:loveImage forState:UIControlStateNormal];
        [loveButton addTarget:self action:@selector(doLove) forControlEvents:UIControlEventTouchUpInside];
        [bgVisualEffectView addSubview:loveButton];
    }
}

- (void)doLove {
    
    if (![[DataBaseHandle shareInstance] isLikeGeQuWithID:self.oneKindList.theID]) {
        
        UIImage *loveImage = [[UIImage imageNamed:@"love.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [loveButton setImage:loveImage forState:UIControlStateNormal];
        CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        k.values = @[@(0.1),@(1.0),@(1.5)];
        k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
        k.calculationMode = kCAAnimationLinear;
        [loveButton.layer addAnimation:k forKey:@"SHOW"];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"心适" message:@"亲！已经收藏到喜欢里面了喔Q_Q" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];

        NSString *indexString = [NSString stringWithFormat:@"%d", self.songIndex];
        [[DataBaseHandle shareInstance] addNewGeQu:self.oneKindList andIndex:indexString];
    
    } else {
        
        UIImage *loveImage = [[UIImage imageNamed:@"loveg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [loveButton setImage:loveImage forState:UIControlStateNormal];
        CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        k.values = @[@(0.1),@(1.0),@(1.5)];
        k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
        k.calculationMode = kCAAnimationLinear;
        [loveButton.layer addAnimation:k forKey:@"SHOW"];
        
        _alertView = [[UIAlertView alloc] initWithTitle:@"心适" message:@"亲！你真的要抛弃我？T_T"delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        
        [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0];
        
        [[DataBaseHandle shareInstance] deleteGeQu:self.oneKindList.theID];
    }
}

- (void)removeAlertView {
    
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)createPlayControlButton {
    
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(0, 0, 20, 20);
    [playButton setImage:[UIImage imageNamed:@"zanting.png"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(playPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    playButton.center = CGPointMake(self.view.center.x, KHEIGHT-150);
    [self.bgImageView addSubview:playButton];
    
    
    if (!self.isCollection) {
        
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
    }
    
}

- (void)createMusicProgressView {
    
    self.musicProgress = [[UISlider alloc] initWithFrame:CGRectMake(20, KHEIGHT-300-20, KWIDTH-40, 20)];
    self.musicProgress.minimumTrackTintColor = [UIColor blackColor];
    self.musicProgress.maximumTrackTintColor = [UIColor grayColor];
    self.musicProgress.minimumValue = 0;
    [self.musicProgress setThumbImage:[UIImage imageNamed:@"thumb1"] forState:UIControlStateNormal];
    [self.musicProgress addTarget:self action:@selector(handlePrograssChangeAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.bgImageView addSubview:self.musicProgress];
    
}

- (void)createLabelView {
    
    self.currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _musicProgress.frame.origin.y + 20, 100, 20)];
    _currentLabel.text = @"0:00";
    _currentLabel.font = [UIFont systemFontOfSize:14];
    _currentLabel.textColor = [UIColor blackColor];
    [self.bgImageView addSubview:_currentLabel];
    
    self.surplusLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH-120, _musicProgress.frame.origin.y + 20, 100, 20)];
    int second = (int)self.musicProgress.maximumValue % 60;
    int minute = (int)self.musicProgress.maximumValue / 60;
    _surplusLabel.textAlignment = NSTextAlignmentRight;
    _surplusLabel.font = [UIFont systemFontOfSize:14];
    _surplusLabel.textColor = [UIColor blackColor];
    _surplusLabel.text = [NSString stringWithFormat:@"%d:%d", minute, second];
    [self.bgImageView addSubview:_surplusLabel];
    
    
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


- (UISlider *)volumeSlider {
    
    if (!_volumeSlider) {
        
        self.volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, KWIDTH-100, 20)];
        
        _volumeSlider.center = CGPointMake(self.view.center.x, 20);
        [_volumeSlider setThumbImage:[UIImage imageNamed:@"thumb1.png"] forState:UIControlStateNormal];
        self.volumeSlider.minimumTrackTintColor = [UIColor blackColor];
        self.volumeSlider.maximumTrackTintColor = [UIColor grayColor];
        _volumeSlider.minimumValueImage = [[UIImage imageNamed:@"yinliang"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        _volumeSlider.maximumValueImage = [[UIImage imageNamed:@""] imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_volumeSlider addTarget:self action:@selector(handleVolumeAction:) forControlEvents:UIControlEventValueChanged];
        
        [self.bgImageView addSubview:_volumeSlider];
    }
    return _volumeSlider;
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

#pragma -- mark 点击下一曲执行的方法
- (void)nextButtonClicked:(UIButton *)sender {
    
    playButton.selected = ![HLAudioStreamer shareStreamer].isPlaying;
    
    InstanceHandle *instance = [InstanceHandle shareInstance];
    
    // 当播放的是最后一首歌的时候切到第一首
    if (self.songIndex == instance.songListArray.count - 1) {
        
        _songIndex = 0;
    } else {
        _songIndex += 1;
    }
    
    // 拿到下一首歌
    OneKindList *one = instance.songListArray[_songIndex];
    
    // 播放下一首歌
    [[HLAudioStreamer shareStreamer] setAudioMediaDataWithURL:one.filename];
    
    // 重新加载视图
    self.songphotoString = one.songphoto;
    self.songerString = one.songer;
    self.songnameString = one.songname;
    self.songtimeString = one.time;
    
    [self reloadMusicPlayerView];
}

#pragma -- mark 点击前一首执行的方法
- (void)previousClicked:(UIButton *)sender {
    
    InstanceHandle *instance = [InstanceHandle shareInstance];
    
    if (self.songIndex == 0) {
        
        self.songIndex = (int)(instance.songListArray.count - 1);
    } else {
        self.songIndex -= 1;
    }
    
    // 拿到上一首歌
    OneKindList *one = instance.songListArray[_songIndex];
    
    // 播放上一首歌
    [[HLAudioStreamer shareStreamer] setAudioMediaDataWithURL:one.filename];
    
    // 重新加载视图
    self.songphotoString = one.songphoto;
    self.songerString = one.songer;
    self.songnameString = one.songname;
    self.songtimeString = one.time;
    
    [self reloadMusicPlayerView];
}

#pragma -- mark 播放进度的进度条
- (void)handlePrograssChangeAction:(UISlider *)sender {
    
    [[HLAudioStreamer shareStreamer] seekToTime:sender.value];
}

#pragma -- mark 滑动音乐音量滑块执行的方法
- (void)handleVolumeAction:(UISlider*)slider {
    
    
    
    
}

#pragma -- mark 播放音乐时会一直调用的方法
-(void)audioStramer:(HLAudioStreamer *)stramer didPlayingWithProgress:(float)progress {
    
    _dickImageView.transform = CGAffineTransformRotate(_dickImageView.transform, M_1_PI/30);
    
    self.musicProgress.value = progress;
    int minute = (int)progress / 60;
    int second = (int)progress % 60;
    self.currentLabel.text = [NSString stringWithFormat:@"%d:%02d", minute, second];
    
    int surplusMinute = (int)(self.musicProgress.maximumValue - progress) / 60;
    int surplusSecond = (int)(self.musicProgress.maximumValue - progress) % 60;
    self.surplusLabel.text = [NSString stringWithFormat:@"%d:%02d", surplusMinute, surplusSecond];
}

#pragma -- mark 音乐播放结束的时候自动调用下一首
- (void)audioStramerDidFinishPlaying:(HLAudioStreamer *)streamer {
    
    // 是否是收藏界面进来的
    if (!self.isCollection) {
        
        [self nextButtonClicked:nil];
        
    } else {
        [[HLAudioStreamer shareStreamer] stop];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
