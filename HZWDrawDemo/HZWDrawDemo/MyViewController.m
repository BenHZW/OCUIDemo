//
//  MyViewController.m
//  HZWDrawDemo
//
//  Created by Gemll on 16/1/26.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "MyViewController.h"
#import "MyView.h"
@interface MyViewController ()
{
    MyView *_myView;
}
@end

@implementation MyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.userInteractionEnabled = YES;
    
    _myView = [[MyView alloc] initWithFrame:self.view.frame];
    _myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myView];
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
