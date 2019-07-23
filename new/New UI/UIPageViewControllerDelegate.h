//
//  UIPageViewControllerDelegate.h
//  New UI
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPageViewControllerDelegate : NSObject<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property(nonatomic,weak)UIStoryboard* storyboard;


@end
