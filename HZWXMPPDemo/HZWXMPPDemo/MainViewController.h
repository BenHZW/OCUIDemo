//
//  MainViewController.h
//  HZWXMPPDemo
//
//  Created by Gemll on 16/1/28.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

#define HostName @"www.gaixuntong.com"
#define Host 5222
@interface MainViewController : UIViewController

//数据流
@property(nonatomic,strong)XMPPStream *xmppStream;

//传输字符串
@property(nonatomic,copy)NSString *message;

@property(nonatomic,copy)void(^SendMessage)(NSString *str);

@end
