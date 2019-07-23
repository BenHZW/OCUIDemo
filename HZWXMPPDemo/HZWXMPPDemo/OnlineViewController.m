//
//  OnlineViewController.m
//  HZWXMPPDemo
//
//  Created by Gemll on 16/2/18.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "OnlineViewController.h"
#import "XMPPFramework.h"
#import "MainViewController.h"
#import "Masonry.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface OnlineViewController ()
{
    //发送内容textfield
    UITextField *_sendTextField;
    
    //接收人textfield
    UITextField *_toTextField;
    
}
@end

@implementation OnlineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"已经在线了");
    
    //输入label
    UILabel *sendWhatLabel = [[UILabel alloc] init];
    [self.view addSubview:sendWhatLabel];
    sendWhatLabel.backgroundColor = [UIColor greenColor];
    sendWhatLabel.text = @"信息";
    [sendWhatLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT / 10);
         make.left.mas_equalTo(self.view.mas_left).with.offset(WIDTH / 8);
         make.width.mas_equalTo(@(WIDTH / 6.9));
         make.height.mas_equalTo(@(HEIGHT / 12.2));
     }];

    
    //输入框
    _sendTextField = [[UITextField alloc] init];
    [self.view addSubview:_sendTextField];
    _sendTextField.placeholder = @"聊天内容";
    [_sendTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT / 10);
         make.left.mas_equalTo(sendWhatLabel.mas_right).with.offset(WIDTH / 20.7);
         make.width.mas_equalTo(@(WIDTH / 4.14));
         make.height.mas_equalTo(@(HEIGHT /12.2));
         
     }];
    _sendTextField.backgroundColor = [UIColor brownColor];
    
    //发送按钮
    UIButton *sendButton = [[UIButton alloc] init];
    [self.view addSubview:sendButton];
    
    //发送按钮的布局设置
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT /6);
         make.left.mas_equalTo(_sendTextField.mas_right).with.offset(WIDTH / 8);
         make.height.mas_equalTo(@(HEIGHT / 7.36));
         make.width.mas_equalTo(@(WIDTH / 4.14));
     }];
    
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sendButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:sendButton];
    [sendButton addTarget:self action:@selector(sendContent) forControlEvents:UIControlEventTouchUpInside];

    //接收人label
    UILabel *toWhoLabel = [[UILabel alloc] init];
    [self.view addSubview:toWhoLabel];
    toWhoLabel.backgroundColor = [UIColor greenColor];
    toWhoLabel.text = @"接收人";
    [toWhoLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_sendTextField.mas_bottom).with.offset(HEIGHT / 14.72);
        make.left.mas_equalTo(self.view.mas_left).with.offset(WIDTH / 8);
        make.width.mas_equalTo(@(WIDTH / 6.9));
        make.height.mas_equalTo(@(HEIGHT / 12.2));
    }];
    
    //接收人textfield
    _toTextField = [[UITextField alloc] init];
    _toTextField.placeholder = @"接收人";
    _toTextField.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_toTextField];
    [_toTextField mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_sendTextField.mas_bottom).with.offset(HEIGHT / 14.72);
        make.left.mas_equalTo(toWhoLabel.mas_right).with.offset(WIDTH / 20.7);
        make.width.mas_equalTo(@(WIDTH / 4.14));
        make.height.mas_equalTo(@(HEIGHT /12.2));
    }];
    
    //接收信息的label
    UILabel *receiveLabel = [[UILabel alloc] init];
    receiveLabel.backgroundColor = [UIColor greenColor];
    receiveLabel.text = @"收信息";
    [self.view addSubview:receiveLabel];
    [receiveLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(toWhoLabel.mas_bottom).with.offset(HEIGHT / 14.72);
        make.left.mas_equalTo(self.view.mas_left).with.offset(WIDTH / 8);
        make.width.mas_equalTo(@(WIDTH / 6.9));
        make.height.mas_equalTo(@(HEIGHT / 12.2));
    }];
    
    //接收的信息
    UILabel *receivedMessageLabel = [[UILabel alloc] init];
    receivedMessageLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:receivedMessageLabel];
    [receivedMessageLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_toTextField.mas_bottom).with.offset(HEIGHT / 14.72);
        make.left.mas_equalTo(receiveLabel.mas_right).with.offset(WIDTH / 20.7);
        make.width.mas_equalTo(@(WIDTH / 3.5));
        make.height.mas_equalTo(@(HEIGHT / 12.2));
    }];
    
    //某个时间接收的信息回调
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if ([obj isKindOfClass:[MainViewController class]])
         {
             MainViewController *obj1 = obj;
             obj1.SendMessage = ^(NSString *str)
             {
                 self.str1 = str;
                 NSLog(@"-----%@",self.str1);
                 receivedMessageLabel.text = str;
             };

         }
     }];
    
    //回收键盘
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
}

#pragma mark - 回收键盘
- (void)viewTapped
{
    [self.view endEditing:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendContent
{
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([obj isKindOfClass:[MainViewController class]])
        {
            MainViewController *obj1 = obj;
            NSString *toName = [NSString stringWithFormat:@"%@@%@",_toTextField.text,HostName];
            XMPPJID *toJID = [XMPPJID jidWithString:toName];
            //创建message对象
            XMPPMessage *message = [XMPPMessage messageWithType:@"text" to:toJID];
            //添加发送内容
            [message addBody:_sendTextField.text];
            //发送消息
            [obj1.xmppStream sendElement:message];
            NSLog(@"已经发出");
        }
    }];
    
   
}

@end
