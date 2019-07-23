//
//  PageViewControllerDelegateDatasource.h
//  UI_5_4
//
//  Created by Ibokan_Teacher on 15/9/15.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <Foundation/Foundation.h>

//遵守pageViewController的两个协议，同时担任两种代理角色
@interface PageViewControllerDelegateDatasource : NSObject<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

//管理用于显示的controller的数组
@property(nonatomic, copy)NSArray *controllers;


@end






