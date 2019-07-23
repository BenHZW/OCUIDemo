//
//  SplitViewControllerDelegate.m
//  Touch3DTableView
//
//  Created by CJJMac on 15/11/20.
//  Copyright © 2015年 CJJMac. All rights reserved.
//

#import "SplitViewControllerDelegate.h"
#import "DetailViewController.h"

@implementation SplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
//    if ([secondaryViewController isKindOfClass:[DetailViewController class]])
//    {
//        return ((DetailViewController*)(secondaryViewController)).transformImage == nil;
//    }
//    
//    return NO;

    return YES;
}

@end
