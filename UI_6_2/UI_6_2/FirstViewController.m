//
//  FirstViewController.m
//  UI_6_2
//
//  Created by Ibokan_Teacher on 15/9/16.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"1st";
    
    
    //导航栏的title可以是一个控件
    UISegmentedControl *titleSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"商户",@"团购"]];
    self.navigationItem.titleView = titleSegmentedControl;
    
    
    //用图片来创建barButtonItem
    UIImage *backImage = [UIImage imageNamed:@"backButton.png"];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //用一个控件来创建barButtonItem
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    //这时候action就应该添加在这个button上
    
    //创建barButtonItem时不用再添加action
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    
    
    self.navigationItem.leftBarButtonItems = @[item1, item2];
    
    
    
    
    //UIToolbar工具条的使用
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(20, 100, 260, 50)];
    [self.view addSubview:toolbar];
    
    //工具条上放的也是barButtonItem
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"item3" style:UIBarButtonItemStyleDone target:nil action:nil];

    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:nil action:nil];
    
    
    
    //限定间距的分隔符
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30;//设置间距
    
    
    //自动调整间距的分隔符
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    
    //将多个item设置在工具条上
    toolbar.items = @[item1, fixedItem, item3, flexibleItem, item4];
    
    
    
    
    
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
