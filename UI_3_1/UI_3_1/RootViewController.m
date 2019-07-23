//
//  RootViewController.m
//  UI_3_1
//
//  Created by Ibokan_Teacher on 15/9/11.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    //单行文本框
    UITextField *_textField1;
}
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
    
    //1.单行文本框
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, 200, 70)];
    [self.view addSubview:_textField1];
    
    
    //2.设置边框样式
    _textField1.borderStyle = UITextBorderStyleRoundedRect;
    
    //3.设置文本对齐方式
    _textField1.textAlignment = NSTextAlignmentCenter;
    
    
    //4.占位符文字
    _textField1.placeholder = @"请输入";
    
    
    //5.键盘样式
    _textField1.keyboardType = UIKeyboardTypeNumberPad;
    
    
    //6.设置密码样式
    //_textField1.secureTextEntry = YES;
    
    
    
    //7.添加响应方法
    [_textField1 addTarget:self action:@selector(textFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    //8.设置文本框代理
    //可以选择控制器作为代理人
    _textField1.delegate = self;
    
    
    //9.添加键盘附件栏
    UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [returnButton setTitle:@"return" forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor grayColor];
    
    //这里target是文本框，就是让文本框执行取消第一响应者（结束编辑）的方法
    [returnButton addTarget:_textField1 action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    
    //将button设置为键盘附件
    _textField1.inputAccessoryView = returnButton;
    
    
    //10.自定义键盘
    UIView *keyBoard = [UIView new];
    keyBoard.backgroundColor = [UIColor yellowColor];
    keyBoard.frame = CGRectMake(0, 0, 1, 120);
    
    //_textField1.inputView = keyBoard;
    
    
    
    
    
}


#pragma mark - 文本框的target-action
- (void)textFieldTextChanged:(UITextField*)textField
{
    NSLog(@"文本框文字发生改变了");
    NSLog(@"textField.text: %@", textField.text);
}


#pragma mark - 文本框的代理方法

//返回告诉文本框是否应该进入编辑状态
/*
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"不能开始编辑");
    return NO;
}*/


//点击return键会执行的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //在这个方法中可以回收键盘
    
    //回收键盘靠的是这个方法
    [textField resignFirstResponder];
    //执行这个方法后，文本框关于EndEditing的代理方法就会被执行
    
    
    return NO;
}


//返回告诉文本框是否应该改变文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //这个方法的任务就是返回“是否应该改变”的布尔值
    //但不要在这里改动文本
    
    
    //利用传入的参数“预测”文本改变之后的结果
    NSString *futureText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSLog(@"当前文本:%@", textField.text);
    NSLog(@"预测文本:%@", futureText);
    
    
    //假设不允许输入超过10个字符
    if (futureText.length > 10)
    {
        NSLog(@"预测文本超过10个字符，不允许这样改变");
        return NO;
    }
    else
    {
        return YES;
    }
    
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
