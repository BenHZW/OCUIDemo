//
//  MyViewController.m
//  HuangzhiwenPageViewControllerDemo
//
//  Created by Gemll on 16/2/19.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"myViewController已经运行");
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [UIButton buttonWithType: UIButtonTypeRoundedRect ];
    [backButton setTitle:@"返回传值" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 跳转传值
- (void)popBack
{
    self.backTo(@"123");
    [self.navigationController popToRootViewControllerAnimated:YES];
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
