//
//  SuccessViewController.m
//  UI_10_2
//
//  Created by Ibokan_Teacher on 15/9/28.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SuccessViewController.h"

@interface SuccessViewController ()
//与IB所关联的控件可以是实例变量，也可以是属性
{
    __weak IBOutlet UILabel *_userNameLabel;
}

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;


@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userNameLabel.text = self.userName;
    
    self.passwordLabel.text = self.password;
    
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
