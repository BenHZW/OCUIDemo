//
//  RootPageViewController.m
//  HuangzhiwenPageViewControllerDemo
//
//  Created by Gemll on 16/2/19.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "RootPageViewController.h"
#import "PageViewControllerDatasource.h"
#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"
@interface RootPageViewController ()
{
    PageViewControllerDatasource *_delegateDataSource;

}
@end

@implementation RootPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.创建对象
    _delegateDataSource = [[PageViewControllerDatasource alloc] init];
    
    self.delegate = _delegateDataSource;
    self.dataSource = _delegateDataSource;
    
    //2.创建三个controller,放入数组
    AViewController *first = [[AViewController alloc] init];
    BViewController *second = [[BViewController alloc] init];
    CViewController *third = [[CViewController alloc] init];
    NSArray *controllers = @[first,second,third];
    
    //交给代理类对象
    _delegateDataSource.controllers = controllers;
    
    //3.设置一开始的显示的页面
    //direction:向前或后的效果设置
    //completion需要传递的参数
    [self setViewControllers:@[first] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
