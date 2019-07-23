//
//  ViewController.m
//  WarningDemo
//
//  Created by Gemll on 16/4/12.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"123");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        NSLog(@"已经操作");
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
