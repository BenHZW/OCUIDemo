//
//  SecondViewController.m
//  UI_6_3
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SecondViewController.h"

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
    self.view.backgroundColor = [UIColor redColor];
    
    //增加一个按钮，用于返回上一个视图控制器
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 80, 40)];
    [self.view addSubview:button];
    
    [button setTitle:@"back" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonPressed
{
    //现在的关系是root呈现2nd
    //如果要返回，则需要让root丢弃2nd
    
    //先要取得这个root的引用
    
    
    //在这个模态视图关系中，root是主动呈现2nd，2nd被root呈现
    //所以2nd的presenting就是root
    
/*
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"丢弃动画结束时执行");
    }];
 */
    
    
    
    //但是写成“自己丢弃”也可以
    //2nd并没有呈现视图，无可丢弃，则这个消息会传递到presenting控制器
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"丢弃动画结束时执行");
    }];
    
    
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
