//
//  TapViewController.m
//  UI_14_3
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TapViewController.h"

@interface TapViewController ()

@end

@implementation TapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //让self.view响应轻拍手势
    
    //1.单击手势
    
    //1.1.创建轻拍手势识别器
    UITapGestureRecognizer *tapOnce =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnce:)];
    
    //1.2.根据需求设置手势识别器的属性
    tapOnce.numberOfTapsRequired = 1;//设定要求的点击次数
    tapOnce.numberOfTouchesRequired = 1 ;//设定触摸的手指个数此值默认为1
    
    //1.3.把手势识别器添加到需要响应的view上
    [self.view addGestureRecognizer:tapOnce];
    
    
    //2.双击手势
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTwice)];
    
    tapTwice.numberOfTapsRequired = 2;
    //tapTwice.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapTwice];
    
    //3.设置手势排斥
    //以下语句的意思是：只有当双击手势检测失败后，才认为是单击
    
    [tapOnce requireGestureRecognizerToFail:tapTwice];
    
}

#pragma mark - 单击手势响应方法
-(void)tappedOnce:(UITapGestureRecognizer*)tap
{
    NSLog(@"单击");
    
    //打印手势的重心坐标点
    CGPoint touchPoint = [tap locationInView:self.view];
    NSLog(@"单击点坐标:%@",NSStringFromCGPoint(touchPoint));
    
    
    
 
}


#pragma mark - 双击手势响应方法
-(void)tappedTwice
{

    NSLog(@"双击");
 
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
