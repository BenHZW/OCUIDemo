//
//  IntoViewController.m
//  New UI
//
//  Created by 3024 on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "IntoViewController.h"

#import "MyPageViewController.h"

@interface IntoViewController ()

@end

@implementation IntoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lvc =[self.storyboard instantiateViewControllerWithIdentifier:@"leftcv"];
    
    self.mainNavigationController =[self.storyboard instantiateViewControllerWithIdentifier:@"navc"];
   
    self.LeftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:self.lvc andMainView:self.mainNavigationController];
    //传个引用过去,方便获取其他视图
    self.lvc.lsvc = self.LeftSlideVC;
    self.lvc.nvc = self.mainNavigationController;
    self.mainNavigationController.lsvc = self.LeftSlideVC;
    
    
    self.navigationBarHidden = YES;
    [self pushViewController:self.LeftSlideVC animated:YES];

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
