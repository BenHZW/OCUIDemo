//
//  PageViewControllerDatasource.h
//  HuangzhiwenPageViewControllerDemo
//
//  Created by Gemll on 16/2/19.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewControllerDatasource : NSObject<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

//管理用于显示的controller的数组
@property(nonatomic,copy)NSArray *controllers;

@end
