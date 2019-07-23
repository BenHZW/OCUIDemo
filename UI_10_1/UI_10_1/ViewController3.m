//
//  ViewController3.m
//  UI_10_1
//
//  Created by Ibokan_Teacher on 15/9/28.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

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
    
    //如果要用autolayout布局的控件，不需要设置frame
    
    UIView *redView = [[UIView alloc] init];
    [self.view addSubview:redView];
    redView.backgroundColor = [UIColor redColor];
    
    
    UIView *blueView = [[UIView alloc] init];
    [self.view addSubview:blueView];
    blueView.backgroundColor = [UIColor blueColor];
    
    
    //使用VFL添加约束
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    //创建约束对象集合
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[redView]-20-[blueView]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(redView, blueView)];
    
    NSLayoutConstraint *constrain2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:2 constant:0];

    //将约束添加到对应的父视图上
    [self.view addConstraints:constraints1];
    [self.view addConstraint:constrain2];
    
    
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
