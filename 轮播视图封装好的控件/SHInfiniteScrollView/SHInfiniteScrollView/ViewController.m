//
//  ViewController.m
//  SHInfiniteScrollView
//
//  Created by 8Bitdo_Dev on 16/4/26.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#import "ViewController.h"
#import "SHScrollView.h"
#import "UIImageView+WebCache.h"
#import "AlertView.h"
@interface ViewController ()<SHScrollViewDelegate>
@property(nonatomic,strong)NSArray *images;
@end

@implementation ViewController
#pragma mark - 轮播视图 改 urlImagesNumber shScrollView.urlImages这两个参数


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SHScrollView *shScrollView=[[SHScrollView alloc]init];
    [self.view addSubview:shScrollView];
    shScrollView.frame=CGRectMake(0, 0, self.view.frame.size.width, 290);
    shScrollView.delegate=self;
    shScrollView.urlImagesNumber = 3;
    shScrollView.placeholderUrlImage=@"replace";
    [shScrollView staryAction];
    //模仿网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        shScrollView.urlImages=@[@"http://e.hiphotos.baidu.com/zhidao/pic/item/cb8065380cd791231b3e7904ab345982b3b780e0.jpg",@"http://c.hiphotos.baidu.com/zhidao/pic/item/b2de9c82d158ccbf5eebf5121bd8bc3eb1354146.jpg",@"http://g.hiphotos.baidu.com/zhidao/pic/item/838ba61ea8d3fd1f77dce0ad364e251f94ca5f4b.jpg"];
        //网络延迟需要更新一下第一张图片
        [shScrollView updateCurrentNetImageView];
    });
    
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(0, 300, self.view.frame.size.width, 300);
    [self.view addSubview:imageView];

}

-(void)SHScrollViewLoadNetImageview:(SHScrollView *)scrollView imageView:(UIImageView *)imageView url:(NSString *)url index:(NSInteger)index
{
    //这里用到SDWebImage
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

-(void)SHScrollView:(SHScrollView *)scrollView didSelectImageViewAtIndex:(NSInteger)index
{
    //这里需要跳转到控制器不然，会导致图片消失
    [AlertView persendDialogBoxTitle:@"点击了" message:@"点击了" targer:self];
}

@end
