//
//  PageViewControllerDelegateDatasource.m
//  UI_5_4
//
//  Created by Ibokan_Teacher on 15/9/15.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "PageViewControllerDelegateDatasource.h"

@implementation PageViewControllerDelegateDatasource
#pragma mark - 数据源代理方法



//返回传入的参数viewController对应的上一页的controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //找到viewController所在的数组中的下标
    NSUInteger vIndex = [self.controllers indexOfObject:viewController];
    //[pageViewController.storyboard instantiateViewControllerWithIdentifier:<#(nonnull NSString *)#>]
    
    //它的前一个controller的index
    NSUInteger preIndex = vIndex - 1;
    
    
    //判断是否越界
    if ( vIndex <= 0)//等于最大的无符号整数
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
    //下一个控制器的index
    NSUInteger vIndex = [self.controllers indexOfObject:viewController];
    
    NSInteger nextIndex = vIndex + 1;
    
    //判断是否越界
    if (vIndex >= self.controllers.count -1)
    {
        return nil;
    }
    else
    {
        return self.controllers[nextIndex];
    }
}


//当pageViewController初始化为横向滑动形式的时候，实现以下两个代理方法，可以自动生成“小圆点”

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    //返回页面点的总数
    return self.controllers.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    //返回被选中的点的下标
    
    //获取pageViewController当前显示的页面
    UIViewController *showedController = pageViewController.viewControllers.firstObject;
    
    //获取这个页面对应的数组下标，并返回
    return [self.controllers indexOfObject:showedController];
}




#pragma mark - 动作时间点代理方法


@end


