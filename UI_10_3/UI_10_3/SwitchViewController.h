//
//  SwitchViewController.h
//  UI_10_3
//
//  Created by Ibokan_Teacher on 15/9/29.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextSwitch.h"

@protocol SwitchViewControllerDelegate;

@interface SwitchViewController : UIViewController

//用TextSwitch模型进行传值
@property(nonatomic, retain)TextSwitch *textSwitch;

//顺便传入对应的单元格的indexPath
@property(nonatomic, retain)NSIndexPath *cellIndexPath;


//使用代理发出开关状态改变的消息
@property(nonatomic, assign)id<SwitchViewControllerDelegate> delegate;

@end



//协议方法
@protocol SwitchViewControllerDelegate <NSObject>

@optional
- (void)switchViewController:(SwitchViewController*)controller;

@end









