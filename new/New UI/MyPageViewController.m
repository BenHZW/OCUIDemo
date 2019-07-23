//
//  MyViewController.m
//  New UI
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyPageViewController.h"
#import "NewsListTableViewController.h"
#import "NewsPictureTableVIewController.h"
#import "NewsVideoTableViewController.h"
#import "UIPageViewControllerDelegate.h"
#import "IntoViewController.h"
#import "NavViewController.h"
@interface MyPageViewController ()
{
    UIPageViewControllerDelegate * _delegate;
    
    
}
@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = [UIPageViewControllerDelegate new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.delegate = _delegate;
    
    self.dataSource = _delegate;
    _delegate.storyboard = self.storyboard;
    
    NSString *identifier = @"index1" ;
    
    UIViewController *vc1 = [_delegate.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    
    [self setViewControllers:@[vc1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    pageControl.backgroundColor = [UIColor whiteColor];

//    pageControl.hidden = YES;
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 40, 40);
    //变圆
    menuBtn.layer.cornerRadius = 20.0;
    menuBtn.layer.masksToBounds = 20.0;
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"man.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
}

- (void) openOrCloseLeftList
{
    NavViewController *navc = (NavViewController*)self.navigationController;
    if(navc.lsvc.closed)
    {
        [navc.lsvc openLeftView];
    }
    else
    {
        [navc.lsvc closeLeftView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
