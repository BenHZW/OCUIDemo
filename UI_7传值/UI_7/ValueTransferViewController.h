//
//  ValueTransferViewController.h
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SuperViewController.h"

//用于传值实验的controller的父类
@interface ValueTransferViewController : SuperViewController<UITextFieldDelegate>

//界面上的文本框
@property(nonatomic, retain)UITextField *textField;

//用于属性传值的属性
@property(nonatomic, copy)NSString *text;


//预留键盘回收时的接口，方便子类重写
- (void)textFieldDidReturn;

@end










