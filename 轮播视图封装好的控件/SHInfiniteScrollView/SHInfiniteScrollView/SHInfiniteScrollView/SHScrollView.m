//
//  SHScrollView.m
//  无限滚动
//
//  Created by 8Bitdo_Dev on 16/4/22.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#define SHScrollViewWidth self.bounds.size.width
#define SHUrlImageSaveKey @"SHUrlImageSaveKey"
#import "SHScrollView.h"

@interface SHScrollView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_centerView;
    UIImageView *_repeatView;
    NSTimer *_timer;
    UIPageControl *_pageControl;
    NSInteger _page;
    NSArray *_oldImages;
}
@end

@implementation SHScrollView

@synthesize interval=_interval,rollInterval=_rollInterval;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView=[[UIScrollView alloc]init];
        _scrollView.pagingEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate=self;
        [self addSubview:_scrollView];
        
        _centerView=[[UIImageView alloc]init];
        _centerView.tag=1;
        [_scrollView addSubview:_centerView];
        
        _repeatView=[[UIImageView alloc]init];
        [_scrollView addSubview:_repeatView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhoto:)];
        UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhoto:)];
        [_centerView addGestureRecognizer:tap];
        [_repeatView addGestureRecognizer:tap2];
        
        _pageControl=[[UIPageControl alloc]init];
        [self addSubview:_pageControl];
        
        _page=0;
        
        self.modeType=SHScrollViewModeRight;
        self.userInteractionEnabled=YES;
        _centerView.userInteractionEnabled=YES;
        _repeatView.userInteractionEnabled=YES;
    }
    return self;
}

-(void)staryAction{
    
    [self readOldImages];
    //初始控件
    [self initView];
    //开启定时滚动
    [self stary];
}

-(void)readOldImages{
    _oldImages =[[NSUserDefaults standardUserDefaults]objectForKey:SHUrlImageSaveKey];
    
}

-(void)initView{
    _scrollView.frame = self.bounds;
    CGFloat w=SHScrollViewWidth;
    CGFloat h=self.bounds.size.height;
    _scrollView.contentSize=CGSizeMake(w * 3, 0);
    _scrollView.contentOffset=CGPointMake(w, 0);
    _centerView.frame=CGRectMake(w, 0, w, h);
    
    //如果没网络图片
    if (!self.urlImages) {
        _centerView.image=[self firstImage];
    }
    
    //使用网络图片 第一次打开
    
    //读取上一次的图片
    if (_oldImages.count>0) {
        if ([self.delegate respondsToSelector:@selector(SHScrollViewLoadNetImageview:imageView:url:index:)]) {
            NSString *urlString=[_oldImages firstObject];
            [self.delegate SHScrollViewLoadNetImageview:self imageView:_centerView url:urlString index:0];
        }
    }else{
        if (_centerView.image==nil) {
            _centerView.image=[UIImage imageNamed:self.placeholderUrlImage];
        }
    }
    
    _repeatView.frame=self.bounds;
    _pageControl.frame=CGRectMake(0, h * 0.85, SHScrollViewWidth, h * 0.15);
    _pageControl.numberOfPages = [self maxCount];
    _pageControl.currentPage = _page;
}

//是否遵守协议
-(BOOL)isDelegate{
    if ([self.delegate respondsToSelector:@selector(SHScrollViewLoadNetImageview:imageView:url:index:)]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark － 判断一些参数
-(NSTimeInterval)interval{
    return _interval ? _interval : 5.0;
}

-(void)setInterval:(NSTimeInterval)interval{
    _interval=interval;
    if (interval <= self.rollInterval) {
        NSLog(@"wraing : interval <= _rollInterval ");
        _interval=3;
    }
}

-(void)setRollInterval:(NSTimeInterval)rollInterval{
    _rollInterval=rollInterval;
    if (self.interval <= _rollInterval) {
        NSLog(@"wraing : interval <= _rollInterval");
        _rollInterval=1;
    }
}

-(NSTimeInterval)rollInterval{
    return _rollInterval ? _rollInterval : 0.4;
}

-(UIImage *)firstImage{
    UIImage *image;
    if (self.images.count>0) {
        image=[UIImage imageNamed:[self.images firstObject]];
    }
    return image;
}

-(NSInteger)maxCount{
    if(self.urlImagesNumber){
        return self.urlImagesNumber;
    }
    return self.urlImages>0 ? self.urlImages.count : self.images.count;
}

-(BOOL)isTimering{
    if (_timer) {
        return YES;
    }else{
        return NO;
    }
}

-(void)setUrlImages:(NSArray *)urlImages{
    _urlImages=urlImages;
    //保存这一次图片
    [[NSUserDefaults standardUserDefaults]setObject:urlImages forKey:SHUrlImageSaveKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark -定时器
-(void)stary{
    _timer=[NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(autoPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)end{
    [_timer invalidate];
}

//动画翻滚
-(void)autoPage{
    switch (self.modeType) {
        case SHScrollViewModeLeft: //滚左
            
        {
            _repeatView.frame = CGRectMake(0, 0, SHScrollViewWidth, self.bounds.size.height);
            [UIView animateWithDuration:self.rollInterval animations:^{
                _scrollView.contentOffset = CGPointMake(1, 0);
            } completion:^(BOOL finished) {
                if (finished) {
                    if (_scrollView.contentOffset.x==SHScrollViewWidth) {
                        _scrollView.contentOffset = CGPointMake(SHScrollViewWidth * 2-0.5 , 0);
                        _scrollView.contentOffset = CGPointMake(SHScrollViewWidth , 0);
                    }else{
                        _scrollView.contentOffset = CGPointMake(0, 0);
                    }
                }
            }];
        }
            
            break;
            
        case SHScrollViewModeRight:  //滚右
            
        {
            _repeatView.frame = CGRectMake(SHScrollViewWidth *2, 0, SHScrollViewWidth, self.bounds.size.height);
            [UIView animateWithDuration:self.rollInterval animations:^{
                _scrollView.contentOffset = CGPointMake(SHScrollViewWidth * 2 - 0.5, 0);
            } completion:^(BOOL finished) {
                if (finished) {
                    if (_scrollView.contentOffset.x==SHScrollViewWidth) {
                        _scrollView.contentOffset = CGPointMake(SHScrollViewWidth * 2-0.5 , 0);
                        _scrollView.contentOffset = CGPointMake(SHScrollViewWidth, 0);
                    }else{
                        _scrollView.contentOffset = CGPointMake(SHScrollViewWidth*2, 0);
                    }
                }else{
                    
                }
            }];
            
        }
            break;
    }
    
}

#pragma mark - 事件
-(void)clickPhoto:(UITapGestureRecognizer *)tap{
    UIImageView *imageView=(UIImageView *)tap.view;
    if ([self.delegate respondsToSelector:@selector(SHScrollView:didSelectImageViewAtIndex:)]) {
        [self.delegate SHScrollView:self didSelectImageViewAtIndex:imageView.tag];
    }
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX=scrollView.contentOffset.x;
    CGFloat w=scrollView.frame.size.width;
    CGRect f=_repeatView.frame;
    NSInteger index=1;
    if (offsetX  > _centerView.frame.origin.x) {//右
        f.origin.x=scrollView.contentSize.width - w;
        index=_centerView.tag +1;
        
        if (index>=[self maxCount] +1) {
            index=1;
        }
        
        //算页码
        if (offsetX >= w*2) {
            _page++;
            if (_page>=[self maxCount]) {
                _page=0;
            }
            _pageControl.currentPage=_page;
        }
        
    }else{
        
        f.origin.x=0;
        index=_centerView.tag -1;
        
        if (index<1) {
            index=[self maxCount];
        }
        
        //算页码
        if (offsetX <= 0) {
            _page--;
            if (_page<0) {
                _page=[self maxCount] - 1;
            }
            _pageControl.currentPage=_page;
        }
        
    }
    
    _repeatView.frame=f;
    _repeatView.tag=index;
    
    //本地图片
    if (!(self.urlImages>0)) {
        if (self.images.count>0) {
            _repeatView.image = [UIImage imageNamed:self.images[index-1]];
        }
    }
    
    //网络无图
    
    
    //网络请求到图片
    if (self.urlImages.count>0 || _oldImages.count>0) {
        if ([self isDelegate]) {
            if (self.urlImages.count>0) {
                [self.delegate SHScrollViewLoadNetImageview:self imageView:_repeatView url:(NSString *)self.urlImages[index-1] index:(NSInteger)self.urlImages[index-1]];
            }else{
                NSString *urlString=_oldImages[index-1];
                [self.delegate SHScrollViewLoadNetImageview:self imageView:_repeatView url:urlString index:(NSInteger)self.urlImages[index-1]];
            }
            
        }
    }else{
        if (_repeatView.image==nil) {
            _repeatView.image=[UIImage imageNamed:self.placeholderUrlImage];
            
        }
    }
    
    
    if (offsetX<=0 || offsetX >= w * 2) {//交换位置
        UIImageView *temp=_centerView;
        _centerView=_repeatView;
        _repeatView=temp;
        
        _centerView.frame=_repeatView.frame;
        _scrollView.contentOffset = CGPointMake(w , 0);
        [_repeatView removeFromSuperview];
        
    }else{
        [_scrollView addSubview:_repeatView];
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self end];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self stary];
}

-(void)updateCurrentNetImageView{
    UIImageView *imageView=[self viewWithTag:_page+1];
    [self.delegate SHScrollViewLoadNetImageview:self imageView:imageView url:self.urlImages[_page] index:0];
}


@end
