//
//  RootViewController.m
//  UI_6_4
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    
    //三个用于弹框的按钮
    UIButton *alertViewButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 150, 70)];
    [self.view addSubview:alertViewButton];
    [alertViewButton setTitle:@"提示框" forState:UIControlStateNormal];
    alertViewButton.backgroundColor = [UIColor redColor];
    
    [alertViewButton addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    UIButton *actionSheetButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 110, 150, 70)];
    [self.view addSubview:actionSheetButton];
    [actionSheetButton setTitle:@"选项列表" forState:UIControlStateNormal];
    actionSheetButton.backgroundColor = [UIColor brownColor];
    [actionSheetButton addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *alertControllerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 210, 150, 70)];
    [self.view addSubview:alertControllerButton];
    [alertControllerButton setTitle:@"警告视图控制器" forState:UIControlStateNormal];
    alertControllerButton.backgroundColor = [UIColor blackColor];
    [alertControllerButton addTarget:self action:@selector(presentAlertController) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - 显示警告视图控制器的方法
- (void)presentAlertController
{
    //3.警告视图控制器（iOS8及以上版本才有）
    //统一了提示框和选项列表的功能，并且以代码块取代代理，处理点击事件
    
    //3.1.提示框样式
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示框标题" message:@"提示信息" preferredStyle:UIAlertControllerStyleAlert];
    
    //增加点击行为对象
    //这个对象不是按钮，但包含着按钮的信息
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"选项1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //这个代码块定义了点击对应按钮的行为
        //可以填nil
        
        //注意这个代码块还会传入一个参数，它就是这个点击行为对象
        NSLog(@"选项1");
    }];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];
    
    
    //把action对象添加到警告视图控制器，就会自动生成对应的按钮
    [alertController addAction:action1];
    [alertController addAction:cancelAction];
    
    
    //给提示框样式添加文本框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //这个代码块的作用是，通过传进来的参数获得刚添加的文本框，从而对齐进行设置等操作
        
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
        
    }];
    
    
    //以模态视图的形式呈现警告视图控制器
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    //3.2.提示列表样式
    //自行尝试
    
}


#pragma mark - 弹出选项列表的方法
- (void)showActionSheet
{
    //2.选项列表
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选项列表标题" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"有破坏性的" otherButtonTitles:@"选项1", @"选项2", @"选项3", nil];
    
    
    //在某个视图中显示
    [actionSheet showInView:self.view];
    
}

#pragma mark - 弹出提示框的方法
- (void)showAlertView
{
    //1.提示框（警告框）
    //如果要处理提示框点击按钮等行为，则需要设置代理
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题" message:@"提示内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"选项1", @"选项2", @"选项3", nil];
    
    
    //可以设置警告框的样式
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    
    //当提示框设置带有文本框后，可以获取它的文本框
    UITextField *loginTextField = [alertView textFieldAtIndex:0];
    UITextField *passwordTextField = [alertView textFieldAtIndex:1];
    
    loginTextField.placeholder = @"用户名";
    passwordTextField.placeholder = @"密码";
    
    
    
    //不需要addSubView，直接呈现即可
    [alertView show];
}


#pragma mark - 提示框代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //根据buttonIndex的不同区分点击了哪个按钮
    NSLog(@"buttonIndex:%ld", buttonIndex);
    
}


#pragma mark - 选项列表的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //根据buttonIndex区分点击不同的按钮
    NSLog(@"buttonIndex:%ld", buttonIndex);
    
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
