//
//  ViewController.m
//  XMPPDemo
//
//  Created by ANAN on 16/1/27.
//  Copyright © 2016年 ANAN. All rights reserved.
//

#import "ViewController.h"
#import "XMPP.h"
#import "AppDelegate.h"

#define UserID @"be9ff1f6a936458c921edcd52ff64b73"
#define HostName @"www.gaixuntong.com"
#define Host 5222

@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self sendContent];
}

-(void)sendContent{
    AppDelegate* app = [UIApplication sharedApplication].delegate;
    //发送给谁
    NSString *toName = [NSString stringWithFormat:@"%@@%@",UserID,HostName];
    XMPPJID *toJID = [XMPPJID jidWithString:toName];
    //创建message对象
    XMPPMessage *message = [XMPPMessage messageWithType:@"text" to:toJID];
    //添加发送内容
    [message addBody:@"冯景安先生"];
    //发送消息
    [app.xmppStream sendElement:message];

}

@end
