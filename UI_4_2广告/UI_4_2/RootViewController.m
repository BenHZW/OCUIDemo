//
//  RootViewController.m
//  UI_4_2
//
//  Created by Ibokan_Teacher on 15/9/14.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"
#import "AdView.h"

//在延展声明遵守协议也可以
@interface RootViewController ()<AdViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //使用自定义视图AdView
    AdView *adv = [[AdView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 100, 80)];
    [self.view addSubview:adv];
    
    
    adv.backgroundColor = [UIColor yellowColor];
    
    
    //设置代理
    adv.delegate = self;
    
}

#pragma mark - 广告条的代理方法
- (BOOL)adViewShouldClose:(AdView *)adView
{
    NSLog(@"关不掉");
    return YES;
}

- (void)adViewDidClose:(AdView *)adView
{
    NSLog(@"关掉了，但是要duang出一个链接");
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
