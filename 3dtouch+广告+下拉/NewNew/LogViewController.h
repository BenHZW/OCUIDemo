//
//  LogViewController.h
//  New UI
//
//  Created by gdm on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfo;
@interface LogViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *password;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property(nonatomic, retain)UserInfo *userInfo;

@end

extern NSString *const NotificationLogInfo;

