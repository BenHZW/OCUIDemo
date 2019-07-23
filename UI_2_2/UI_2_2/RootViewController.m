//
//  RootViewController.m
//  UI_2_2
//
//  Created by Ibokan_Teacher on 15/9/9.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

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
    
    //1.按钮
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 100, 70)];
    
    [self.view addSubview:button1];
    
    
    //设置按钮的文字和文字颜色
    [button1 setTitle:@"button1" forState:UIControlStateNormal];
    
    //UIControlStateNormal可表示按钮的一般状态
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //UIControlStateHighlighted可表示按钮按下去的状态
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    
    //设置按钮图片
    
    //UIImage是存储图片数据的类
    UIImage *buttonImg = [UIImage imageNamed:@"aButton.png"];
    
    [button1 setImage:buttonImg forState:UIControlStateNormal];
    
    //尝试setBackgroundImage
    
    
    
    //2.创建系统样式的按钮
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.view addSubview:button2];
    
    [button2 setTitle:@"button2" forState:UIControlStateNormal];
    
    button2.frame = CGRectMake(140, 30, 100, 40);
    
    
    //3.为按钮添加响应行为
    //参数①：执行方法的对象
    //参数②：要执行的方法selector
    //参数③：按钮响应的事件
    
    [button1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //不同的按钮可以响应不同的方法，但也可以响应同一个方法
    [button2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //用tag属性区分不同的控件
    button1.tag = 100;
    button2.tag = 101;
    
    
    //4.标签控件
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 160, 120, 60)];
    
    [self.view addSubview:label1];
    
    //设置标签文字
    label1.text = @"label1!!!";
    
    //设置文字颜色
    label1.textColor = [UIColor blueColor];
    
    //设置文字字体
    label1.font = [UIFont italicSystemFontOfSize:30];
    
    
    label1.tag = 200;
    
}


#pragma mark - 按钮响应执行的方法

//当按钮响应此方法的时候，发生响应的按钮会作为参数传进来。可以不写这个参数。
- (void)buttonPressed:(UIButton*)button
{
    NSLog(@"按钮被点击");
    
    //通过tag值获取某个子视图
    //比如要获取tag值为200的label1
    UILabel *label1 = (UILabel*)[self.view viewWithTag:200];
    
    
    
    //获取button的tag值，对按钮加以区分
    switch (button.tag)
    {
        case 100:
            NSLog(@"button1");
            label1.text = @"button1";
            break;
        
        case 101:
            NSLog(@"button2");
            label1.text = @"button2";
            break;
            
        default:
            break;
    }
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
