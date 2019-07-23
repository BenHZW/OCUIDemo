//
//  SetViewController.m
//  UI_10_3
//
//  Created by Ibokan_Teacher on 15/9/29.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
{
    __weak IBOutlet UILabel *_titleLabel;
    
}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标签文字
    _titleLabel.text = self.title;
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
