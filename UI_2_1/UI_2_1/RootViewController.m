//
//  RootViewController.m
//  UI_2_1
//
//  Created by Ibokan_Teacher on 15/9/9.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    //子视图
    UIView *_view2;
}
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
    
    //在这里添加控件
    
    //1.添加一个视图UIView
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 200, 200)];
    NSLog(@"view1.retainCount:%lu", view1.retainCount);
    
    //父视图添加子视图
    [self.view addSubview:view1];
    
    NSLog(@"view1.retainCount:%lu", view1.retainCount);
    
    
    //设置颜色
    view1.backgroundColor = [UIColor redColor];
    
    
    
    //继续添加
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 200, 200)];
    
    [self.view addSubview:_view2];
    
    _view2.backgroundColor = [UIColor grayColor];
    
    
    //2.子视图操作
    
    //获取某个子视图的父视图
    UIView *superViewOfView2 = _view2.superview;
    NSLog(@"superViewOfView2 == self.view ? %d", superViewOfView2 == self.view);
    
    
    //获取某个父视图的所有（直接）子视图
    NSArray *subViewsOfSelfView = self.view.subviews;
    NSLog(@"subViewsOfSelfView:%@", subViewsOfSelfView);
    
    //改变子视图的层次关系
    [self.view bringSubviewToFront:view1];
    
    
    //子视图从父视图中移除
    [view1 removeFromSuperview];
    
    [view1 release];
    
    
    //3.子视图上还可以继续添加子视图
    UIView *view3 = [UIView new];
    view3.frame = CGRectMake(0, 0, 100, 70);
    
    //子视图的原点坐标是以（直接）父视图作为参考的，父视图对子视图默认的坐标原点就是父视图自己的左上角
    [_view2 addSubview:view3];
    
    view3.backgroundColor = [UIColor greenColor];
    
    
    //父视图的bounds属性能影响子视图的位置
    //一般不改动bounds的宽高，只根据需要改变bounds的原点即可
    
    CGRect view2Bounds = _view2.bounds;
    
    //这样其实是修改了子视图参考父视图的左上角的坐标
    view2Bounds.origin = CGPointMake(-20, -20);
    
    _view2.bounds = view2Bounds;
    
    
    [view3 release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    //释放_view2
    [_view2 release];
    [super dealloc];
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
