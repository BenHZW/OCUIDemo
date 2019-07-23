//
//  RootViewController.m
//  UI_5_1
//
//  Created by Ibokan_Teacher on 15/9/15.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //1.创建图片
    UIImage *img = [UIImage imageNamed:@"screenshot.png"];
    
    //创建用于显示图片的控件
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    imageView.tag = 10;
    
    //2.创建滚动视图ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, 250, 350)];
    [self.view addSubview:scrollView];
    
    
    
    //将图片控件添加上去
    [scrollView addSubview:imageView];
    
    
    //只有contentSize比frame.size大，才能滚动
    scrollView.contentSize = imageView.frame.size;
    
    
    //设置代理
    scrollView.delegate = self;
    
    
//    //设置缩放比例范围
//    scrollView.maximumZoomScale = 2;
//    scrollView.minimumZoomScale = 0.5;
//    
    
//    //代码设定缩放到什么比例
//    scrollView.zoomScale = 1.5;
    
}

#pragma mark - 滚动视图的一些代理方法

//有任何滚动都会调用的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"did scroll");
    
    //比如查看移动的偏移量
    CGPoint offset = scrollView.contentOffset;
    
    NSLog(@"offset: %@", NSStringFromCGPoint(offset));
}


//返回一个被scrollView缩放的子视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    //比如这里返回那个imageView
    UIView *view = [scrollView viewWithTag:10];
    
    return view;
}


//发生缩放动作时会调用的方法
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"Did Zoom");
    NSLog(@"scale: %f", scrollView.zoomScale);
}


#pragma mark

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
