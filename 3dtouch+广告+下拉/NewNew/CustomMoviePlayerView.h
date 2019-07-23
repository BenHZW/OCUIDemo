//
//  CustomMoviePlayerView2.h
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//
#import "UIViewExt.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>      //导入视频播放库

@protocol CustomMoviePlayerViewDelegate <NSObject>
@optional
- (void)goBuyMultimedia;
- (void)addPlayCount;
- (void)playDelegate;
@end

@class MovieDetailsModel;
@interface CustomMoviePlayerView : UIView{
    
}

@property (nonatomic, strong) UIViewController *viewController;;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) NSString *movieURL; //视频地址
@property (strong,nonatomic)  UIButton *payButton;
@property (nonatomic, weak) id<CustomMoviePlayerViewDelegate> delegate;
@property(nonatomic)NSString* backImage;
//准备播放
- (void)readyPlayer;
@property (nonatomic, assign) BOOL isContinuePlay;

@end
