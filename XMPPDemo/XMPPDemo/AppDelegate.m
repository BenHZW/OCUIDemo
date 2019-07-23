//
//  AppDelegate.m
//  XMPPDemo
//
//  Created by ANAN on 16/1/27.
//  Copyright © 2016年 ANAN. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPP/XMPPFramework.h"


@interface AppDelegate ()
{
    XMPPReconnect* _xmppReconnect;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.xmppStream = [[XMPPStream alloc]init];
    
    //注册回调方法
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    //重连类
    _xmppReconnect = [XMPPReconnect new];
    [_xmppReconnect activate:self.xmppStream];
    
    //设置服务器ip地址
    [_xmppStream setHostName:HostName];
    //设置端口号 (取决于服务器里面设置成什么)
    [_xmppStream setHostPort:Host];

    [self xmppConnect];
    return YES;
}

#pragma mark - XMPP连接
-(void)xmppConnect{
    //设置当前用户ID
    XMPPJID *myJID = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",UserID,HostName]];
    [self.xmppStream setMyJID:myJID];
    NSError *error = nil;
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        NSLog(@"连接服务器出错：%@",[error localizedDescription]);
    }else{
        NSLog(@"连接服务器成功");
    }
}


//*********  连接  *********
#pragma mark - 连接服务器成功后的回调
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSError *error = nil;
    //认证密码
    [self.xmppStream authenticateWithPassword:@"123456" error:&error];
    if (error){
        NSLog(@"认证错误：%@",[error localizedDescription]);
    }else{
        NSLog(@"已经连接");
    }
}

#pragma mark - 和服务器断开后的回调
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    NSLog(@"已经和服务器断开,原因:%@",[error localizedDescription]);
}

//*********  登陆  **********
#pragma mark - 认证成功后的回调
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"登陆成功");
    //通知服务器 登陆状态
    [self.xmppStream sendElement:[XMPPPresence presence]];
    
}


#pragma mark - 认证失败后的回调
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    NSLog(@"登陆失败:%@",error);
    //在服务器上注册密码
    [self.xmppStream registerWithPassword:@"123456" error:nil];
}

//*********  注册  **********
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功！");
    //用密码再登陆
    [self.xmppStream authenticateWithPassword:@"123456" error:nil];
}

-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"注册失败:%@",error);
}

//*********  接收到消息   **********
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSLog(@"\n\n类型 = %@\n内容 =%@\n从哪里来 = %@\n\n",message.type,message.body,message.fromStr);

}








@end
