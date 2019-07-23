//
//  IntoViewController.h
//  New UI
//
//  Created by 3024 on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "NavViewController.h"
#import "LeftViewController.h"
@interface IntoViewController : UINavigationController

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) LeftViewController *lvc;
@property (strong, nonatomic) NavViewController *mainNavigationController;

@end
