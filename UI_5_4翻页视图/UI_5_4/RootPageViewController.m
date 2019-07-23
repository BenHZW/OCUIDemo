//
//  RootPageViewController.m
//  UI_5_4
//
//  Created by Ibokan_Teacher on 15/9/15.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootPageViewController.h"
#import "PageViewControllerDelegateDatasource.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface RootPageViewController ()
{
    //由于使用了NSObject的子类作为代理人，它在此之前并没有被任何对象强引用过，为防止其过早释放，这里才对它使用强引用
    PageViewControllerDelegateDatasource *_delegateDataSource;
}
@end

@implementation RootPageViewController

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
    self.view.backgroundColor = [UIColor blueColor];
    
    
    //1.创建代理对象
    _delegateDataSource = [PageViewControllerDelegateDatasource new];
    
    
    self.delegate =_delegateDataSource;
    self.dataSource = _delegateDataSource;
    
    //2.创建三个controller，放入数组
    FirstViewController *first = [FirstViewController new];
    SecondViewController *second = [SecondViewController new];
    ThirdViewController *third = [ThirdViewController new];
    NSArray *controllers = @[first, second, third];
    
    //交给代理类对象
    _delegateDataSource.controllers = controllers;
    
    
    //3.设置一开始显示的页面是
    //参数①：当前要显示的页面（controller），根据书脊的设置不同，填入一个或两个controller的数组
    //参数②：前翻或后翻效果选择
    //参数③：是否有动画
    //参数④：翻页结束后执行的代码块，可以为nil
    [self setViewControllers:@[first] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
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
