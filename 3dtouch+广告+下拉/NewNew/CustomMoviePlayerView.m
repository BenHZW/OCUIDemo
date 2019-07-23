//
//  CustomMoviePlayerView2.m
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#define KDeviceFrame [UIScreen mainScreen].bounds

#import "CustomMoviePlayerView.h"
#import "SDWebImage/UIImageView+WebCache.h"
@interface CustomMoviePlayerView(){
    UIActivityIndicatorView *loadingAni;        //加载动画
    CGRect lastBound;
    CGPoint lastCenter;
    CGAffineTransform lastTransform;
    UIImageView *jiePingImage;//截屏
    
}
@end


@implementation CustomMoviePlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor blackColor]];
        
        loadingAni = [[UIActivityIndicatorView alloc] init];
        loadingAni.size = CGSizeMake(37, 37);
        loadingAni.center = self.center;
        loadingAni.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [self addSubview:loadingAni];
   
        _payButton = [[UIButton alloc] init];
        [self addSubview:_payButton];
        _payButton.size = CGSizeMake(30, 30);
        _payButton.center = CGPointMake(self.center.x, self.center.y - 10);
        [_payButton setImage:[UIImage imageNamed:@"multimedia_pay"] forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(readyPlayer) forControlEvents:UIControlEventTouchUpInside];
        
        _moviePlayer =  [[MPMoviePlayerController alloc] init];
        _isContinuePlay = YES;
    }
    
    return self;
}

-(void)setBackImage:(NSString*)backImage
{
    _backImage = backImage;
    jiePingImage = [[UIImageView alloc] initWithFrame:self.frame];
    [jiePingImage sd_setImageWithURL:[NSURL URLWithString:_backImage] placeholderImage:[UIImage imageNamed:@"load.png"]] ;
    [self addSubview:jiePingImage];
    
    [self bringSubviewToFront:self.payButton];
}

- (void)isPay:(BOOL)isPay
{
    _payButton.userInteractionEnabled = isPay;
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification
{
    [loadingAni stopAnimating];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerLoadStateDidChangeNotification
                                                  object:nil];
    
    if ([_moviePlayer loadState] != MPMovieLoadStateUnknown){
        [[_moviePlayer view] setFrame:self.frame];
        
        [self addSubview:[_moviePlayer view]];
        if (_isContinuePlay) {
            [_moviePlayer play];
        }else{
            [_moviePlayer pause];
        }
        
    }
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //还原状态栏为默认状态
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    // Remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:nil];
    
}

#pragma mark 进入全屏
- (void)moviePlayEnterFullscreen:(NSNotification*)notification
{
    lastBound = self.bounds;
    lastCenter = self.center;
    lastTransform = self.transform;
    [_moviePlayer pause];
    
    //设置横屏
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    [self setBounds:[UIScreen mainScreen].bounds];
    [self setCenter:CGPointMake(kDeviceWidth * .5, KDeviceHeight * .5)];

    [self setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    [[_moviePlayer view] setFrame:self.frame];
    [_moviePlayer play];
}

#pragma mark 退出全屏
- (void)moviePlayExitFullscreen:(NSNotification*)notification
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    [self setBounds:lastBound];
    [self setCenter:lastCenter];

    [self setTransform:lastTransform];
    [[_moviePlayer view] setFrame:self.frame];
    [_moviePlayer play];
}


- (void) readyPlayer
{
    if ([_delegate respondsToSelector:@selector(playDelegate)]) {
        [_delegate playDelegate];
    }
    _payButton.hidden = YES;
    [loadingAni startAnimating];

    [_moviePlayer stop];

    _moviePlayer.contentURL = [NSURL URLWithString:_movieURL];
    _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    if ([_moviePlayer respondsToSelector:@selector(loadState)])
    {
        [_moviePlayer setControlStyle:MPMovieControlStyleEmbedded];
        //满屏
        [_moviePlayer setFullscreen:YES];
        // 有助于减少延迟
        [_moviePlayer prepareToPlay];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayerLoadStateChanged:)
                                                     name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object:nil];
        
        //电影结束
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        
        //进入全屏
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayEnterFullscreen:)
                                                     name:MPMoviePlayerDidEnterFullscreenNotification
                                                   object:nil];
        
        //退出全屏
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayExitFullscreen:)
                                                     name:MPMoviePlayerWillExitFullscreenNotification
                                                   object:nil];
    }
    else
    {
        [_moviePlayer play];
    }
}

- (void)buyPlayer
{

    if ([_delegate respondsToSelector:@selector(goBuyMultimedia)]) {
        [_delegate goBuyMultimedia];
    }
}

-(void)setMovieURL:(NSString *)movieURL{
    _movieURL = movieURL;
    [self isPay:YES];
}
@end
