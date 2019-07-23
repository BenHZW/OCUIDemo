//
//  IntoViewController.m
//  New UI
//
//  Created by 3024 on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "IntoViewController.h"
#import "SettingTableViewController.h"

@interface IntoViewController ()

{
    UIView *_backgroundView;
}

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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(settingNightMode:) name:SettingNightMode object:nil];
    
    self.navigationBarHidden = YES;
    [self pushViewController:self.LeftSlideVC animated:YES];
    

    _backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    _backgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backgroundView];
    _backgroundView.userInteractionEnabled = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)settingNightMode:(NSNotification*)notification
{
    SettingTableViewController *setvc = notification.object;
    
    
    if (setvc != nil)
    {
        if (setvc.setOrCancelNightMode)
        {
            
            
            _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
          
        }
        else
        {
            
            _backgroundView.backgroundColor = [UIColor clearColor];
        }
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (BOOL)shouldAutorotate
{
    return NO;
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
