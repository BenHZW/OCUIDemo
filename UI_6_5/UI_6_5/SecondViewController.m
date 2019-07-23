//
//  SecondViewController.m
//  UI_6_5
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //让标签按钮上的图案显示原色
        UIImage *unselectedImg = [UIImage imageNamed:@"1_unselected.png"];
        
        self.tabBarItem.image = [unselectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"1_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        self.title = @"微博";
        
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
