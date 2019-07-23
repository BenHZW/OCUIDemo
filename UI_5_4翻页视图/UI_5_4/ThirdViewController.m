//
//  ThirdViewController.m
//  UI_5_3
//
//  Created by Ibokan_Teacher on 15/9/15.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 0, 0)];
    
    [self.view addSubview:aSwitch];
    
    [aSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    NSLog(@"333");
    
}

- (void)switchValueChanged:(UISwitch*)aSwitch
{
    NSLog(@"开关状态：%d", aSwitch.on);
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
