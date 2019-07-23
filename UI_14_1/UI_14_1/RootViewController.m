//
//  RootViewController.m
//  UI_14_1
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "MyView.h"
@interface RootViewController ()

@end

@implementation RootViewController

-(void)viewDidLoad {
    [super viewDidLoad];
   //1.更换控制器自带的view
    MyView *superView = [MyView new];
    self.view = superView;
    
    superView.name = @"superView";
    
    //2.子视图subView1
    MyView *subView1 = [[MyView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    
    [self.view addSubview:subView1];
    
    subView1.name = @"subView1";
    
    subView1.backgroundColor = [UIColor redColor];
    
    //3.子视图subView2
    MyView *subView2 = [[MyView alloc] initWithFrame:CGRectMake(100, 100, 250, 250)];
    
    [self.view addSubview:subView2];
    
    subView2.name = @"subView2";
    
    subView2.backgroundColor = [UIColor greenColor];
    
    //4.在subView2上再放两个字视图
    
    MyView *subView2_1 = [[MyView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    
    
    [subView2 addSubview:subView2_1];
    
    subView2_1.name = @"subView2_1";
    
    subView2_1.backgroundColor = [UIColor blueColor];
    
    MyView *subView2_2 = [[MyView alloc]initWithFrame:CGRectMake(20, 20, 50, 50)];
    
    [subView2 addSubview:subView2_2];
    
    subView2_2.name = @"subView2_2";
    
    subView2_2.backgroundColor = [UIColor yellowColor];
    
 //5.每一个View都有一个决定能否进行用户交互的属性
    //subView2_2.userInteractionEnabled = NO;
    subView2.userInteractionEnabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 重写触摸事件方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Root View Controller touches began");
    
    [self.nextResponder touchesBegan:touches withEvent:event];
 



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
