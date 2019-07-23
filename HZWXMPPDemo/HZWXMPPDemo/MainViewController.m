//
//  MainViewController.m
//  HZWXMPPDemo
//
//  Created by Gemll on 16/1/28.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "MainViewController.h"
#import "PostViewController.h"
#import "XMPPFramework.h"
#import "Masonry.h"
#import "OnlineViewController.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface MainViewController ()
{
    //重连对象
    XMPPReconnect *_xmppReconnect;

    //注册返回的用户名
    NSString *_idStr;
    
    //注册返回的密码
    NSString *_passwordStr;
    
    //当前的登录输入框
    UITextField *_loginTextField;
    
    //当前的密码输入框
    UITextField *_passwordTextField;
    
    //设置断开的标记
    NSInteger _tag;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //获取屏幕大小
    /*
    float height = [UIScreen mainScreen].bounds.size.height;
    float width = [UIScreen mainScreen].bounds.size.width;
    NSLog(@"高%f 宽%f",height,width);
    */
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
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:loginButton];
    
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
        //make.width.mas_equalTo(@200);
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
    
    //按钮的布局设置
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(passwordlabel.mas_bottom).with.offset(HEIGHT / 14.72);
        make.left.mas_equalTo(self.view.mas_left).with.offset(WIDTH / 4.14);
        make.height.mas_equalTo(@(HEIGHT / 7.36));
        make.width.mas_equalTo(@(WIDTH / 3.45));
    }];
    
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor yellowColor];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
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
#pragma mark - 注册
- (void)pushThePostController
{
    PostViewController *postViewController = [PostViewController new];
    
    [self.navigationController pushViewController:postViewController animated:YES];
    
    //设置当前用户ID
    postViewController.Popback = ^(NSString *str1, NSString *str2)
    {
       _idStr = str1;
        
        _passwordStr = str2;
        
        [self.xmppStream registerWithPassword:_passwordStr error:nil];
        
        NSLog(@"使用%@重新注册",_passwordStr);
    };
    
}

#pragma mark - 登录
- (void)login
{
 
    
    self.xmppStream = [[XMPPStream alloc] init];
    
    //注册回调方法，检查是否有注册
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()]
    ;
    //重连类
     _xmppReconnect= [[XMPPReconnect alloc]init];
    [_xmppReconnect activate:self.xmppStream];
    
    //设置服务器ip地址
    [_xmppStream setHostName:HostName];
    //设置端口号
    [_xmppStream setHostPort:Host];
    
    //开始连接
    [self xmppConnect];

}

#pragma mark - XMPP连接
- (void)xmppConnect
{
    //设置当前用户ID
    NSString* str = [NSString stringWithFormat:@"%@@%@",_loginTextField.text,HostName];
    NSLog(@"----%@",str);
    
    //配置XMPPJID
    XMPPJID *myJID = [XMPPJID jidWithString:str];
    [self.xmppStream setMyJID:myJID];
    NSError *error = nil;
    
    //检查连接是否成功
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error)
    {
        NSLog(@"连接服务器出错");
    }
    else
    {
        NSLog(@"连接服务器成功");
    }
}

#pragma mark - 连接成功后的回调
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSError *error = nil;
    //认证密码
    NSLog(@"认证密码%@",_passwordStr);
    [self.xmppStream authenticateWithPassword:_passwordTextField.text error:&error];
    if(error)
    {
        NSLog(@"认证错误");
    }
    else
    {
        NSLog(@"认证成功");
    }
    
}

#pragma mark - 和服务器断开后的回调
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"已经和服务器断开");
    
    _tag = 1;

}

#pragma mark - 认证成功后的回调
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    
    NSLog(@"登录成功,已经处于登录状态");
    [self pushToOnlineViewController];
    [self.xmppStream sendElement:[XMPPPresence presence]];
    
}

#pragma mark - 成功认证跳到Online页面
- (void)pushToOnlineViewController
{
    if (_tag != 1)
    {
        OnlineViewController *onlineViewController = [[OnlineViewController alloc] init];
        [self.navigationController pushViewController:onlineViewController animated:YES];
        
    }
}

#pragma mark - 认证失败后的回调
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"登录失败");
    //跳转注册反向传值

   [self pushThePostController];
    
    

}

#pragma mark - 注册
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"注册成功");
    
    [self.xmppStream authenticateWithPassword:_passwordStr error:nil];
    
}

-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    NSLog(@"注册失败: %@",error);
     [self.xmppStream registerWithPassword:_passwordStr error:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 接收信息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"\n\n 类型 = %@\n内容 = %@\n 从哪里来 = %@\n\n",message.type,message.body,message.fromStr);

    self.message = message.body;
    //接收信息后传值
    self.SendMessage(self.message);
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
