//
//  HLAudioStreamer.m
//  HLMusicPlayer
//
//  Created by 侯垒 on 15/7/26.
//  Copyright (c) 2015年 侯垒. All rights reserved.
//

#import "HLAudioStreamer.h"
#import <AVFoundation/AVFoundation.h>

@interface HLAudioStreamer ()

@property(nonatomic,strong)AVPlayer *audioPlayer;    // 播放器对象
@property(nonatomic,strong)NSTimer  *timer;          // 定时器对象

@end


@implementation HLAudioStreamer

-(AVPlayer *)audioPlayer
{
    if (!_audioPlayer)
    {
        self.audioPlayer = [[AVPlayer alloc]init];
    }
    return _audioPlayer;
}


+(instancetype)shareStreamer
{
    static HLAudioStreamer *streamer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        streamer = [[HLAudioStreamer alloc]init];
    });
    return streamer;
}

-(void)setAudioMediaDataWithURL:(NSString *)urlString
{
    // 如果有一个item正在播放，先把原来的删了（换歌的时候用）
    if (self.audioPlayer.currentItem)
    {
        [self.audioPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    }
    // 根据指定的url创建一个AVPlayerItem对象
    // _isPlaying = NO;
    AVPlayerItem *currentItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:urlString]];
    // 给当前的item添加一个观察者
    [currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    // 根据给定的item对象，替换音频播放器当前的item
    [self.audioPlayer replaceCurrentItemWithPlayerItem:currentItem];
    [self.audioPlayer play];
}

-(instancetype)init
{
    if (self = [super init])
    {
        // 从写初始化方法就在于在刚开始创建的时候就添加一个观察值，观察音乐是不是播放完毕
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleEndTimeNotifation:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

-(void)play
{
    [self.audioPlayer play];
    // 如果已经有计时器了那就可以直接返回来
    if (self.timer)
    {
        return;
    }
    // 没有定时器的时候创建一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(handleTimerAction:) userInfo:nil repeats:YES];
    // 播放的属性默认是NO的，这里要改为yes
    _isPlaying = YES;
}

-(void)pause
{
    [self.audioPlayer pause];
    // 暂停的时候计时器也要停止
    [self.timer invalidate];
    self.timer = nil;
    _isPlaying = NO;
}

-(void)stop
{
    // 停止的时候，先暂停
    [self pause];
    // CMTimeMake(a,b)    a当前第几帧, b每秒钟多少帧.当前播放时间a/b
    [self.audioPlayer seekToTime:CMTimeMake(0, self.audioPlayer.currentTime.timescale)];
    
}

-(void)setVolume:(float)volume
{
    self.audioPlayer.volume = volume;
}
-(float)volume
{
    return self.audioPlayer.volume;
}

-(float)totalTime
{
    return CMTimeGetSeconds([self.audioPlayer.currentItem duration]);
}
/**
 *  滑动进度条执行的方法
 *
 *  @param time 时间
 */
-(void)seekToTime:(float)time
{
    // 先暂停
    [self pause];
    // 调节时间到自己想要的时间
    [self.audioPlayer seekToTime:CMTimeMakeWithSeconds(time, self.audioPlayer.currentTime.timescale)];
    // 继续播放
    [self play];
}

#pragma - mark计时器关联的方法
-(void)handleTimerAction:(NSTimer *)timer
{
    // 如果代理存在并且遵守了协议
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioStramer:didPlayingWithProgress:)])
    {
        float progress = self.audioPlayer.currentTime.value / self.audioPlayer.currentTime.timescale;
        [self.delegate audioStramer:self didPlayingWithProgress:progress];
        self.totalTime = CMTimeGetSeconds([self.audioPlayer.currentItem duration]);
    }
}

-(void)handleEndTimeNotifation:(NSNotification *)notification
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(audioStramerDidFinishPlaying:)])
    {
        [self.delegate audioStramerDidFinishPlaying:self];
    }
    
}
-(BOOL)isPlayingCurrentAudioWithURL:(NSString *)urlString
{
    //NSLog(@"urlString = %@",urlString);
    NSString *currentURLString = [(AVURLAsset *) self.audioPlayer.currentItem.asset URL].absoluteString;
    //NSLog(@"currentUrlString=%@",currentURLString);
    return [currentURLString isEqualToString:urlString];
}

//KVO观察到属性变化后执行的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch ([change[@"new"] integerValue])
    {
        case AVPlayerItemStatusFailed:
            NSLog(@"播放失败");
            break;
        case AVPlayerItemStatusReadyToPlay:
            _isPrepared = YES;
            NSLog(@"准备完毕");
            break;
            case AVPlayerItemStatusUnknown:
            NSLog(@"url不识别");
            break;
            
        default:
            break;
    }

}


@end












