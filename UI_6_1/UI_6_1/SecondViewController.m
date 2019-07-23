//
//  SecondViewController.m
//  UI_6_1
//
//  Created by Ibokan_Teacher on 15/9/16.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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
    
    self.title = @"2nd";
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    //添加一个按钮，能返回上一页
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor whiteColor];
    
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    //在导航栏上放置按钮
    //这里将用来推到下一个页面
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(barButtonPressed)];
    self.navigationItem.rightBarButtonItem = nextItem;
    
    
    
    //显示导航控制器自带的工具条
    self.navigationController.toolbarHidden = NO;
    
    //显示导航条
    self.navigationController.navigationBarHidden = NO;
    
    
}

- (void)barButtonPressed
{
    ThirdViewController *third = [ThirdViewController new];
    [self.navigationController pushViewController:third animated:YES];
}

- (void)buttonPressed
{
    //返回上一页
    [self.navigationController popViewControllerAnimated:YES];
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
