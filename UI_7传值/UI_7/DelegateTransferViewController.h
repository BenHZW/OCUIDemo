//
//  DelegateTransferViewController.h
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ValueTransferViewController.h"

@protocol DelegateTransferViewControllerDelegate;

//代理传值实验
@interface DelegateTransferViewController : ValueTransferViewController

//代理
@property(nonatomic, assign)id<DelegateTransferViewControllerDelegate> delegate;

@end


//用于传值的代理方法(协议)
@protocol DelegateTransferViewControllerDelegate <NSObject>

- (void)controllerTextFieldDidConfirm:(DelegateTransferViewController*)dtvc;

@end






