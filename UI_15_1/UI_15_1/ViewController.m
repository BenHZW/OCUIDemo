//
//  ViewController.m
//  UI_15_1
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *_greenView;

@property (weak, nonatomic) IBOutlet UIView *_yellowView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //提前认识一下layer的锚点
    self._yellowView.layer.anchorPoint = CGPointZero;
    
    
    
    
}
- (IBAction)viewAnimation1
{
    
    //1.开始设定动画
    [UIView beginAnimations:nil context:nil];
    
    //2.设置动画的相关特性
    //动画时间
    [UIView setAnimationDuration:3];
    
    //延迟时间
    [UIView setAnimationDelay:1];
    
    
    //3.设定在动画结束时，相关的view的最终状态
    self._yellowView.frame = CGRectMake(245, 100, 50, 50);
    
    self._yellowView.backgroundColor = [UIColor greenColor];
    
    self._greenView.backgroundColor = [UIColor blueColor];
    self._greenView.frame = CGRectMake(245, 100, 50, 50);
    
    //4.提交动画,动画会开始执行
    [UIView commitAnimations];
    
}

- (IBAction)viewAnimation2
{
    [UIView animateWithDuration:5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        //在这个代码块里设置view的最终状态
        self._yellowView.transform = CGAffineTransformRotate(self._yellowView.transform, M_PI_2);
        
    } completion:^(BOOL finished) {
       
        //执行动画结束时需要做的操作
        NSLog(@"旋转动画结束");
     //设置可以接着执行另外一个动画
        [self viewAnimation1];
    
    
    }];
    

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    




}

@end
