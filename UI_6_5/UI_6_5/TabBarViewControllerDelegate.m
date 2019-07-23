//
//  TabBarViewControllerDelegate.m
//  UI_6_5
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "TabBarViewControllerDelegate.h"

@implementation TabBarViewControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"selected: %@", viewController.title);
    NSLog(@"selected index: %lu", tabBarController.selectedIndex);
}


@end






