//
//  NotificationTransferViewController.m
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "NotificationTransferViewController.h"


//通知名字符串的赋值
NSString *const NotificationTransferViewControllerTextConfirmedNotification = @"NotificationTransferViewControllerTextConfirmedNotification";



@interface NotificationTransferViewController ()

@end

@implementation NotificationTransferViewController

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
    self.title = @"通知传值";
}

#pragma mark - 重写父类预留接口
- (void)textFieldDidReturn
{
    [super textFieldDidReturn];
    
    //发出文本框确认修改的通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:NotificationTransferViewControllerTextConfirmedNotification object:self userInfo:nil];
    
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
