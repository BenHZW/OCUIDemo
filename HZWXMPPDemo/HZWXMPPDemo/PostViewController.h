//
//  PostViewController.h
//  HZWXMPPDemo
//
//  Created by Gemll on 16/1/28.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController<UINavigationControllerDelegate,UINavigationBarDelegate>

@property(nonatomic,copy) void(^Popback)(NSString *str1, NSString *str2);
@end
