//
//  LeftViewController.h
//  New UI
//
//  Created by 3024 on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "NavViewController.h"
#import "LogViewController.h"
@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)LeftSlideViewController *lsvc;
@property(nonatomic,strong)NavViewController *nvc;
@property(nonatomic,retain)UITableView *tableview;

@property(nonatomic)BOOL isLogin;

@end
