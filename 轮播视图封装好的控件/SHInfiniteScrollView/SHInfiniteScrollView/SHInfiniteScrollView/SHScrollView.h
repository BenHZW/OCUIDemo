//
//  SHScrollView.h
//  无限滚动
//
//  Created by 8Bitdo_Dev on 16/4/22.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SHScrollViewModeLeft,
    SHScrollViewModeRight,
} SHScrollViewModeType;

@class SHScrollView;
@protocol SHScrollViewDelegate <NSObject>
@optional

-(void)SHScrollViewLoadNetImageview:(SHScrollView *)scrollView imageView:(UIImageView *)imageView url:(NSString *)url index:(NSInteger)index;
-(void)SHScrollView:(SHScrollView *)scrollView didSelectImageViewAtIndex:(NSInteger)index;
@end


@interface SHScrollView : UIView
@property(nonatomic,weak)id<SHScrollViewDelegate> delegate;
#pragma mark - 读取本地图片
//图片
@property(nonatomic,strong)NSArray *images;

//图片链接
@property(nonatomic,strong)NSArray *urlImages;
//图片链接个数(用于提示位置 pageControl)
@property(nonatomic,assign)NSInteger urlImagesNumber;
//图片链接展位图（用于，获取服务器图片url过慢时显示展位图）
@property(nonatomic,copy)NSString *placeholderUrlImage;
//每一页翻滚时间 默认是5.0秒
@property(nonatomic,assign)NSTimeInterval interval;
//翻滚时间 默认是0.4秒
@property(nonatomic,assign)NSTimeInterval rollInterval;
//自动翻滚方向默认是右
@property(nonatomic,assign)SHScrollViewModeType modeType;
//判断自动滚动定时器状态
@property(nonatomic,assign,getter=isTimering)BOOL timering;
/*开始滚动*/
-(void)staryAction;
//开始自动滚动 默认开启
-(void)stary;
//结束滚动
-(void)end;
//如果用到网络需要更新一下第一张图片
-(void)updateCurrentNetImageView;
@end
