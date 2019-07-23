//
//  RootViewController.m
//  UI_5_3
//
//  Created by Ibokan_Teacher on 15/9/15.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

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
    
    //1.创建三种控制器
    FirstViewController *first = [FirstViewController new];
    SecondViewController *second = [SecondViewController new];
    ThirdViewController *third = [ThirdViewController new];
    
    
    //2.添加为本控制器的子控制器
    [self addChildViewController:first];
    [self addChildViewController:second];
    [self addChildViewController:third];
    
    
    //3.创建一个3页全屏scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    //分成3页
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame) * 3, 0);
    
    //4.将3个controller上的view添加到scrollView上
    [scrollView addSubview:first.view];
    
    
    [scrollView addSubview:second.view];
    CGRect secondFrame = second.view.frame;
    secondFrame.origin.x = secondFrame.size.width;
    second.view.frame = secondFrame;
    
    
    [scrollView addSubview:third.view];
    CGRect thirdFrame = third.view.frame;
    thirdFrame.origin.x = thirdFrame.size.width * 2;
    third.view.frame = thirdFrame;
    
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
