//
//  ViewController.m
//  UIDatePicker的创建与使用
//
//  Created by 陈家庆 on 15-2-9.
//  Copyright (c) 2015年 shikee_Chan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 80,self.view.frame.size.width, 216)];
    [self.view addSubview:self.datePicker];
    //设置显示格式
    //默认根据手机本地设置显示为中文还是其他语言
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    self.datePicker.locale = locale;
    
    [self.view addSubview:_showLabel];
}


- (void)didReceiveMemoryWarning
{
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
