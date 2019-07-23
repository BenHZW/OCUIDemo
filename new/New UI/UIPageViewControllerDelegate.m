 //
//  UIPageViewControllerDelegate.m
//  New UI
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIPageViewControllerDelegate.h"

@implementation UIPageViewControllerDelegate
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSInteger value = [[viewController valueForKeyPath:@"value"] integerValue];
    
    NSString* a;
    NSString *b;
    
    NSInteger valued = value - 1;
    //越界问题
    if (valued < 1) {
        
        return nil;
        
    }
    b = [NSString stringWithFormat: @"%ld",valued];
    
    a  = [@"index" stringByAppendingString: b];
    
    
    return   [self.storyboard instantiateViewControllerWithIdentifier:a];
    
    
    
    
    
}


-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger value = [[viewController valueForKeyPath:@"value"] integerValue];
    
    
    NSString *a;
    NSString* b;
    
    NSInteger valued = value + 1;
    
    
    if (valued > 3) {
        
        
        return nil;
    }
    
    b= [NSString stringWithFormat:@"%ld",valued];
    
    a  =  [@"index"  stringByAppendingString:b];

    return [self.storyboard instantiateViewControllerWithIdentifier:a];
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0)
{
    return 3;
    
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    
    
    
    return 0;
    
}

@end
