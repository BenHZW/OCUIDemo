//
//  ThirdViewController.m
//  UI_6_1
//
//  Created by Ibokan_Teacher on 15/9/16.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    self.title = @"3rd";
    
    //创建一个按钮用于直接弹出到栈底页面
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonPressed
{
    //直接弹出到栈底
    [self.navigationController popToRootViewControllerAnimated:YES];
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
