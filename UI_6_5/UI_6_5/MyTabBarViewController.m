//
//  MyTabBarViewController.m
//  UI_6_5
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "TabBarViewControllerDelegate.h"

@interface MyTabBarViewController ()
{
    //给代理人设为强引用
    TabBarViewControllerDelegate *_theDelegate;
}
@end

@implementation MyTabBarViewController

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
    
    //取得标签栏
    UITabBar *tabBar = self.tabBar;
    
    
    //设置颜色
    tabBar.backgroundColor = [UIColor yellowColor];
    tabBar.barTintColor = [UIColor brownColor];
    
    
    //设置选中的图标的填充色
    tabBar.tintColor = [UIColor blackColor];
    
    
    //设置背景图片
    tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_background.png"];
    
    //设置阴影图片
    tabBar.shadowImage = [UIImage imageNamed:@"tabBar_shadow.png"];
    
    
    //设置选中的标签的标记图案
    tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tick.png"];
    
    
    //设置tabBarViewController的代理
    _theDelegate = [TabBarViewControllerDelegate new];
    self.delegate = _theDelegate;
    
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
