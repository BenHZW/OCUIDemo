//
//  NavViewController.m
//  New UI
//
//  Created by 3024 on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
#pragma mark - 触摸事件的四个方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSLog(@"touch.force,%lf",touch.force);
    NSLog(@"%@ touches bagan",self);
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touches cancelled",self);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touches ended",self);
    UITouch *touch = [touches anyObject];
    if (touch.force > 1) {
        [self openOrCloseLeftList];

    }
    NSLog(@"touch.force,%lf",touch.force);
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touches moved",self);
}

- (void) openOrCloseLeftList
{
    
    if(self.lsvc.closed)
    {
        [self.lsvc openLeftView];
    }
    else
    {
        [self.lsvc closeLeftView];
    }
    
}

@end
