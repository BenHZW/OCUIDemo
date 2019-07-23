//
//  MyViewController.h
//  HuangzhiwenPageViewControllerDemo
//
//  Created by Gemll on 16/2/19.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property(nonatomic,copy)void(^backTo)(NSString*str);

@end
