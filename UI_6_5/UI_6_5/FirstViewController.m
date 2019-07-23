//
//  FirstViewController.m
//  UI_6_5
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //设置的标题会被tabBar自动读取，显示在标签按钮上
        self.title = @"微信";
        
        
        //设置tabBar按钮的图案
        self.tabBarItem.image = [UIImage imageNamed:@"0_unselected.png"];
        
        //设置选中这一页时按钮的图案
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"0_selected.png"];
        
        //设置标签按钮的红色圆点文字
        self.tabBarItem.badgeValue = @"new";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
