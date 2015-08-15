//
//  HLAudioStreamer.h
//  HLMusicPlayer
//
//  Created by 侯垒 on 15/7/26.
//  Copyright (c) 2015年 侯垒. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HLAudioStreamer;
@protocol HLAudioStreamerDelegate <NSObject>
@optional
-(void)audioStramer:(HLAudioStreamer *)stramer didPlayingWithProgress:(float)progress;
-(void)audioStramerDidFinishPlaying:(HLAudioStreamer *)streamer;
@end



@interface HLAudioStreamer : NSObject
// 关于播放器的一些播放设置
@property (nonatomic) float volume;   // 播放器的音量
@property (nonatomic) id<HLAudioStreamerDelegate> delegate;
@property (nonatomic) float totalTime;
@property (nonatomic) BOOL isPlaying; // 判断是否正在播放
@property (nonatomic) BOOL isPrepared;// 判断是否准备完成

+(instancetype)shareStreamer;
-(void)play;
-(void)pause;
-(void)stop;

// 设置音频的URL
-(void)setAudioMediaDataWithURL:(NSString *)urlString;
// 跳转到指定的时间播放
-(void)seekToTime:(float)time;
// 判断是否正在播放指定的URL
-(BOOL)isPlayingCurrentAudioWithURL:(NSString *)urlString;

@end







