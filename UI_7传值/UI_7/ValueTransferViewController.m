//
//  ValueTransferViewController.m
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ValueTransferViewController.h"

@interface ValueTransferViewController ()

@end

@implementation ValueTransferViewController

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
    
    
    //布置文本框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    [self.view addSubview:self.textField];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    
    //设置代理用于回收键盘
    self.textField.delegate = self;
    
    //从text属性获得文本，并显示在文本框上
    //这一句也是属性传值的体现
    self.textField.text = self.text;
    
}

#pragma mark - 实现回收键盘代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //调用预留的接口方法
    [self textFieldDidReturn];
    
    return NO;
}

#pragma mark - 预留的接口
//这里什么都不用做，具体行为留给子类重写
- (void)textFieldDidReturn{}



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
