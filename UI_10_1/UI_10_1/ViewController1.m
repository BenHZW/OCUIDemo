//
//  ViewController1.m
//  UI_10_1
//
//  Created by Ibokan_Teacher on 15/9/28.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

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
    // Do any additional setup after loading the view from its nib.
}


//每个视图控制器都能单独检测并处理屏幕旋转状态

//重写以下父类方法

#pragma mark - iOS7~8

//是否允许屏幕自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

//返回屏幕初始方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

//返回允许的屏幕方向
- (NSUInteger)supportedInterfaceOrientations
{
    //返回值应为UIInterfaceOrientationMask的枚举值选项（可以多项选择）
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}

#pragma mark - iOS7
//检测到屏幕将要旋转时执行的方法
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"iOS7 %f秒后屏幕转到方向%ld", duration, toInterfaceOrientation);
}


#pragma mark - iOS8
//检测到屏幕将要旋转时执行的方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"iOS8 屏幕转向后尺寸为%@", NSStringFromCGSize(size));
    
    //通过通知栏的位置判断屏幕方向
    NSLog(@"屏幕方向为%ld", [UIApplication sharedApplication].statusBarOrientation );
    
    //参数coordinator是一个实现了一些能执行UI动画的实例方法
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        //设置UI动画控件的最终状态
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        NSLog(@"动画执行完毕执行");
        
    }];
    
}









@end
