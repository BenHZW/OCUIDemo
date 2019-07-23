//
//  RootViewController.m
//  UI_6_3
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

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
    self.view.backgroundColor = [UIColor greenColor];
    
    //增加一个按钮，点击后以模态视图的形式呈现下一个视图
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 70, 30)];
    [self.view addSubview:button];
    
    [button setTitle:@"next" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

- (void)buttonPressed
{
    SecondViewController *second = [SecondViewController new];
    
    //设定模态视图的呈现效果
    second.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    
    //模态视图:用root呈现second
    [self presentViewController:second animated:YES completion:^{
        NSLog(@"呈现动画结束时执行");
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
