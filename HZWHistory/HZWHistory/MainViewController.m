//
//  MainViewController.m
//  HZWHistory
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "MainViewController.h"
#import "HZWRequestModel.h"
#import "HZWjsonModel.h"
#import <Masonry.h>
#import "ShowTableViewController.h"

@interface MainViewController ()
{
    UITextField *_textField;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _textField = [[UITextField alloc]init];
    [self.view addSubview:_textField];
    _textField.placeholder = @"请输入要查找的日期";
    [_textField mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.view.mas_top).with.offset(200);
        make.left.mas_equalTo(self.view.mas_left).with.offset(100);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-100);
        make.height.mas_equalTo(@100);
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"查找" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.view.mas_top).with.offset(220);
        make.left.mas_equalTo(_textField.mas_right).with.offset(30);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@40);
    }];
    [button addTarget:self action:@selector(searchTheHistory) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)searchTheHistory
{
    ShowTableViewController *showTVC = [[ShowTableViewController alloc] init];
    [self.navigationController pushViewController:showTVC animated:YES];
    showTVC.date = _textField.text;
}

- (void)didReceiveMemoryWarning
{
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
