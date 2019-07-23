//
//  RootViewController.m
//  UI_5_2
//
//  Created by Ibokan_Teacher on 15/9/15.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    UIScrollView *_scrollView;
    
    
    UIPageControl *_pageControl;
}
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
    
    
    //1.创建scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor greenColor];
    
    //2.设置contentSize横向为frame.size的3倍
    _scrollView.contentSize = CGSizeMake(900, 0);
    //设置分页显示
    _scrollView.pagingEnabled = YES;
    
    
    //3.随便往上面添加点东西
    //子视图的frame以scrollView的contentSize为参照
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 100, 50)];
    [_scrollView addSubview:v1];
    v1.backgroundColor = [UIColor redColor];
    
    
    UILabel *v2 = [[UILabel alloc] initWithFrame:CGRectMake(350, 40, 70, 40)];
    [_scrollView addSubview:v2];
    v2.text = @"我是v2";
    
    
    
    UISwitch *v3 = [[UISwitch alloc] initWithFrame:CGRectMake(630, 70, 0, 0)];
    [_scrollView addSubview:v3];
    
    
    
    
    
    //4.创建分页控制器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 300, 100, 20)];
    [self.view addSubview:_pageControl];
    
    CGPoint pageControlCenter = _pageControl.center;
    pageControlCenter.x = _scrollView.center.x;
    _pageControl.center = pageControlCenter;
    
    
    //5.设置页面（点）的数量和颜色
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    
    
    //6.让两者联动
    
    //设置scrollView的代理
    _scrollView.delegate = self;
    
    
    //给pageControl添加action
    [_pageControl addTarget:self action:@selector(pageControlPageNumberChanged:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - pageControl的action
- (void)pageControlPageNumberChanged:(UIPageControl*)pageControl
{
    NSLog(@"页面改变");
    
    NSInteger pageNumber = pageControl.currentPage;
    
    //计算scrollView的对应页面偏移量，实现联动
    CGPoint offset = CGPointMake(300 * pageNumber, 0);
    [_scrollView setContentOffset:offset animated:YES];
}


#pragma mark - scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"滑动停止");
    //scrollView滑动时联动pageControl
    _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x) / 300;
}


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
