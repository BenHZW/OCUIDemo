//
//  FirstViewController.m
//  UI_6_1
//
//  Created by Ibokan_Teacher on 15/9/16.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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
    
    //设置本视图控制器的标题，会在导航栏上显示
    self.title = @"1st";
    
    //---------------------------
    
    //设置视图边缘(iOS7开始才有)
    //if ( [UIDevice currentDevice].systemVersion.floatValue >= 7.0 )//判断设备系统版本
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //---------------------------
    
    //添加一个按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)buttonPressed
{
    //推到下一个视图控制器（推到下一个页面）
    
    SecondViewController *second = [SecondViewController new];
    
    [self.navigationController pushViewController:second animated:YES];
    
    
    
    //-------------------
    
    //自定义返回到本页面的返回按钮
    
    //BarButtonItem也能添加点击后执行的action
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style: UIBarButtonItemStyleBordered target:nil action:nil];
    
    //当被设定为返回按钮后，返回的action会被自动添加上去，所以我们不用填
  self.navigationItem.backBarButtonItem = backItem;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //隐藏工具条和导航条
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
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
