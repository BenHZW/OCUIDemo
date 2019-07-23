//
//  MainViewController.m
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "MainViewController.h"
#import "DictionaryViewController.h"
#import "IdiomViewController.h"
@interface MainViewController ()
{
    UIButton *_dictionaryButton;
    UIButton *_idiomButton;
}
@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:176 / 255.0 blue:171 / 255.0 alpha:1];
#pragma mark - UI
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"字典&&成语";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:35];
    titleLabel.textColor = [UIColor redColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@100);
        make.top.mas_equalTo(self.view.mas_top).with.offset(100);
    }];
    
    _dictionaryButton = [[UIButton alloc] init];
    _dictionaryButton.backgroundColor = [UIColor grayColor];
    [_dictionaryButton setTitle:@"字典查找" forState:UIControlStateNormal];
    [_dictionaryButton.titleLabel setFont:[UIFont systemFontOfSize:23]];
    _dictionaryButton.layer.cornerRadius = 6;
    [self.view addSubview:_dictionaryButton];
    [_dictionaryButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(titleLabel.mas_width);
        make.height.mas_equalTo(titleLabel.mas_height);
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(70);
    }];
    [_dictionaryButton addTarget:self action:@selector(pushToNextController) forControlEvents:UIControlEventTouchUpInside];
    
    
    _idiomButton = [[UIButton alloc] init];
    _idiomButton.backgroundColor = [UIColor grayColor];
    [_idiomButton setTitle:@"成语查找" forState:UIControlStateNormal];
    [_idiomButton.titleLabel setFont:[UIFont systemFontOfSize:23]];
    _idiomButton.layer.cornerRadius = 10;
    [self.view addSubview:_idiomButton];
    [_idiomButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.view.mas_centerX);
         make.width.mas_equalTo(_dictionaryButton.mas_width);
         make.height.mas_equalTo(_dictionaryButton.mas_height);
         make.top.mas_equalTo(_dictionaryButton.mas_bottom).with.offset(70);
     }];
    [_idiomButton addTarget:self action:@selector(pushToNextController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushToNextController
{
    if (_dictionaryButton.highlighted == YES)
    {
        [self.navigationController pushViewController:[[DictionaryViewController alloc] init] animated:YES];
    }
    if (_idiomButton.highlighted == YES)
    {
        [self.navigationController pushViewController:[[IdiomViewController alloc] init] animated:YES];
    }
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
