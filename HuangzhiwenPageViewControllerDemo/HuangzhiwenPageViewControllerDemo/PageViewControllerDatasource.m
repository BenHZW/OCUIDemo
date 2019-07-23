//
//  PageViewControllerDatasource.m
//  HuangzhiwenPageViewControllerDemo
//
//  Created by Gemll on 16/2/19.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "PageViewControllerDatasource.h"

@implementation PageViewControllerDatasource

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //找到当前viewController所在的数组的下标
    NSUInteger vIndex = [self.controllers indexOfObject:viewController];
    
    //它的前一个controller的index
    NSUInteger preIndex = vIndex - 1;
    
    //判断是否越界
    if (vIndex <= 0)
    {
        //返回空则无法翻页
        return nil;
    }
    else
    {
        return self.controllers[preIndex];
    }
}

//返回下一页的controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //获取当前viewController所在数组的下标
    NSUInteger vIndex = [self.controllers indexOfObject:viewController];
    //下一个controller的下标
    NSInteger nextIndex = vIndex + 1;
    //判断是否越界
    if (vIndex >= self.controllers.count - 1)
    {
        return nil;
    }
    else
    {
        return self.controllers[nextIndex];
    }
}

#pragma mark - 当pageViewController初始化为横向滑动形式的时候，实现下面两个代理方法就会自动生成小圆点
//-------------------------------------------------
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    //返回页面点的总数
    return self.controllers.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    //返回被选中的点的下标
    
    //获取pageViewController当前显示的页面
    UIViewController *currentController = pageViewController.viewControllers.firstObject;
    
    //获取这个页面对应的数组下标，并返回
    return [self.controllers indexOfObject:currentController];
}



@end
