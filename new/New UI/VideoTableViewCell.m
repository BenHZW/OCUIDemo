//
//  VideoTableViewCell.m
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "VideoTableViewCell.h"

@interface VideoTableViewCell()
{
    AVPlayerLayer *playerLayer;
    AVPlayer *_player;
}

@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@property (weak, nonatomic) IBOutlet UIButton *playBut;


@end

@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.playBut setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    self.commentImg.image = [UIImage imageNamed:@"comment.png"];
    //初始不播放
    self.isPlay = NO;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)palyButPressed:(id)sender {
    if(_player.rate==0){
        
        [self playVideo];
    }else
    {
        [self stopVideo];
        
    }

}
-(void)playVideo
{
    if (!_player) {
        NSURL *movieURL = [NSURL URLWithString:self.item.videourl];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:movieURL];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        
        [self addProgressObserver];
        [self addNotification];
        [self addObserverToPlayerItem:playerItem];
        
        playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        
        playerLayer.frame = self.aImageVIew.bounds;
        [self.aImageVIew.layer addSublayer:playerLayer];
    }
    _titleLabel.hidden = YES;
    [self.playBut setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    [_player play];

    self.isPlay = YES;

}

-(void)stopVideo
{
    _titleLabel.hidden = NO;
    [self.playBut setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [_player pause];
    self.isPlay = NO;
}


-(void)dealloc{
    [self removeObserverFromPlayerItem:_player.currentItem];
    [self removeNotification];
}

#pragma mark - 通知
/**
 *  添加播放器通知
 */
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  播放完成通知
 */
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    [playerLayer removeFromSuperlayer];
}

#pragma mark - 监控
/**
 *  给播放器添加进度更新
 */
-(void)addProgressObserver{
    AVPlayerItem *playerItem=_player.currentItem;
    UIProgressView *progress=self.progress;
    //这里设置每秒执行一次
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current=CMTimeGetSeconds(time);
        float total=CMTimeGetSeconds([playerItem duration]);
        NSLog(@"当前已经播放%.2fs.",current);
        if (current) {
            [progress setProgress:(current/total) animated:YES];
        }
    }];
}

//AVPlayerItem添加监控
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

/**
 *  通过KVO监控播放器状态会调方法
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
    }
}

@end
