//
//  AppDelegate.h
//  XMPPDemo
//
//  Created by ANAN on 16/1/27.
//  Copyright © 2016年 ANAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

//为登录用户的id   用户信息一般有 用户ID(服务器与客户端用于区分用户的凭证) 用户名  用户密码
#define UserID @"be9ff1f6a936458c921edcd52ff64b73"
#define HostName @"www.gaixuntong.com"
#define Host 5222




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) XMPPStream * xmppStream;

-(void)xmppConnect;


@end

