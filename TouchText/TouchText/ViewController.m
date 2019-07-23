//
//  ViewController.m
//  TouchText
//
//  Created by Gemll on 16/2/14.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
@interface ViewController ()

@property (nonatomic, strong) MyView *myView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myView = [[MyView alloc]initWithFrame:CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width - 100, 200)];
    _myView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_myView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    tap.cancelsTouchesInView = YES;
    //tap.delaysTouchesBegan = YES;
    //tap.delaysTouchesEnded = YES;
    //[_myView addGestureRecognizer:tap];
    [self.view addGestureRecognizer:tap];

}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"点击");

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"开始");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"动作已完成");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"停止");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸移动");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
