//
//  PostViewController.m
//  HZWXMPPDemo
//
//  Created by Gemll on 16/1/28.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "PostViewController.h"
#import "Masonry.h"
#import "MainViewController.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface PostViewController ()
{
     UITextField *_passwordTextField;

     UITextField *_loginTextField;
}
@end

@implementation PostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //用户名label
    UILabel *userlabel = [[UILabel alloc]init];
    [self.view addSubview:userlabel];
    
    //密码label
    UILabel *passwordlabel = [[UILabel alloc] init];
    [self.view addSubview:passwordlabel];
    
    //用户名text
    _loginTextField = [[UITextField alloc] init];
    [self.view addSubview:_loginTextField];
    
    
    //密码text
    
    _passwordTextField = [[UITextField alloc] init];
    [self.view addSubview:_passwordTextField];
    
    //注册按钮
    
    UIButton *postButton = [[UIButton alloc] init];
    [self.view addSubview:postButton];
    
    //Userlabel布局设置
    [userlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT / 6.7);
         make.left.mas_equalTo(self.view.mas_left).with.offset(WIDTH / 20.7);
         make.height.mas_equalTo(@(HEIGHT / 7.36));
         make.width.mas_equalTo(@(WIDTH / 3.45));

     }];
    userlabel.text = @"Username";
    userlabel.backgroundColor = [UIColor greenColor];
    
    //Passwordlabel布局设置
    [passwordlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(userlabel.mas_bottom).with.offset(HEIGHT / 14.72);
         make.left.mas_equalTo(self.view.mas_left).with.offset(WIDTH / 20.7);
         make.height.mas_equalTo(@(HEIGHT / 7.36));
         make.width.mas_equalTo(@(WIDTH / 3.45));
     }];
    passwordlabel.text = @"Password";
    passwordlabel.backgroundColor = [UIColor greenColor];
    
    //用户名textField布局设置
    [_loginTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT / 6.7);
         make.left.mas_equalTo(passwordlabel.mas_right).with.offset(WIDTH / 8.28);
         make.height.mas_equalTo(@(HEIGHT / 7.36));
         make.right.mas_equalTo(self.view.mas_right).with.offset(-(WIDTH / 20.7));

     }];
    _loginTextField.backgroundColor = [UIColor brownColor];
    _loginTextField.placeholder = @"用户名";
    
    //密码textField布局设置
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_loginTextField.mas_bottom).with.offset(HEIGHT / 14.72);
         make.left.mas_equalTo(passwordlabel.mas_right).with.offset(WIDTH / 8.28);
         make.height.mas_equalTo(@(HEIGHT / 7.36));
         //make.width.mas_equalTo(@200);
         make.right.mas_equalTo(self.view.mas_right).with.offset(-(WIDTH / 20.7));

     }];
    _passwordTextField.backgroundColor = [UIColor brownColor];
    _passwordTextField.placeholder = @"密码";
    
    //注册按钮的布局设置
    [postButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(passwordlabel.mas_bottom).with.offset(HEIGHT / 14.72);
         make.left.mas_equalTo(self.view.mas_left).with.offset(WIDTH / 5);
         make.height.mas_equalTo(@(HEIGHT / 7.36));
         make.width.mas_equalTo(@(WIDTH / 3.45));
     }];
    
    [postButton setTitle:@"注册" forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    postButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:postButton];
    [postButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
        
    
    //回收键盘
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
}



#pragma mark - 回收键盘手势
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
}


#pragma mark - 注册并登录
- (void)popBack
{
    self.Popback(_loginTextField.text,_passwordTextField.text);
   /*
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([obj isKindOfClass:[MainViewController class]])
        {
            MainViewController *obj1 = obj;
            [obj1 login];
        }
    }];
    */
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
