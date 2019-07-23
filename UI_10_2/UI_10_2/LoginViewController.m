//
//  LoginViewController.m
//  UI_10_2
//
//  Created by Ibokan_Teacher on 15/9/28.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "LoginViewController.h"
#import "SuccessViewController.h"

@interface LoginViewController ()
{
    
    __weak IBOutlet UITextField *_userNameTextField;
    
    __weak IBOutlet UITextField *_passwordTextField;
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//通过连线跳转前的准备工作
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //从segue中可以获得连线的标识符，以及由哪个视图控制器跳转到哪个视图控制器
    //sender就是连线的触发者
    
    //用标识符区分不同连线，执行对应的操作
    if ([segue.identifier isEqualToString:@"success"])
    {
        //本例中需要属性传值
        
        //取得目标视图控制器
        SuccessViewController *destinationViewController = segue.destinationViewController;
        
        //传值
        destinationViewController.userName = _userNameTextField.text;
        destinationViewController.password = _passwordTextField.text;
    }
}

#pragma mark - 文本框代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - 按钮点击的响应方法

- (IBAction)tableButtonPressed:(UIButton *)sender
{
    NSLog(@"即将要推到某表视图了哦~");
    
    //使用代码跳转到连线
    //这个方法应该由连线的出发点的视图控制器来调用
    [self performSegueWithIdentifier:@"table" sender:sender];
}




@end















