//
//  RootViewController.m
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"
#import "DelegateTransferViewController.h"
#import "BlockTransferViewController.h"
#import "NotificationTransferViewController.h"
#import "KVOTransferViewController.h"

//遵守代理传值的协议
@interface RootViewController ()<DelegateTransferViewControllerDelegate>
{
    UILabel *_label;
}
@end

@implementation RootViewController

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
    
    //布置一个label和四个按钮
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    [self.view addSubview:_label];
    _label.font = [UIFont systemFontOfSize:30];
    _label.text = @"原始文字";
    
    
    
    //for循环布置按钮
    NSArray *buttonTitle = @[@"代理传值", @"代码块传值", @"通知传值", @"KVO传值"];
    for (NSInteger i = 0; i < 2; ++i)
    {
        for (NSInteger j = 0; j < 2; ++j)
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + j * 110, 45 + i * 45, 100, 40)];
            [self.view addSubview:button];
            
            //设置标题和tag值
            [button setTitle:buttonTitle[i * 2 + j] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.tag = i * 2 + j;
            
            
            
            //给按钮添加响应方法
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    
    
    //添加自身作为通知的观察者
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(recievedNotification:) name:NotificationTransferViewControllerTextConfirmedNotification object:nil];
    
}

#pragma mark - 收到通知回调的方法
- (void)recievedNotification:(NSNotification*)notification
{
    //取出通知发送者
    NotificationTransferViewController *ntvc = notification.object;
    
    //从中取出文本框文字
    _label.text = ntvc.textField.text;
}


#pragma mark - 按钮点击响应方法
- (void)buttonPressed:(UIButton*)button
{
    switch (button.tag) {
        case 0:     //代理传值
        {
            //创建代理传值的视图控制器，并推过去
            DelegateTransferViewController *dtvc = [DelegateTransferViewController new];
            
            
            //这里还必须涉及正向的传递文本的过程
            //用到属性传值
            dtvc.text = _label.text;
            
            //设置代理关系
            dtvc.delegate = self;
            
            //推入
            [self.navigationController pushViewController:dtvc animated:YES];
            
        }
            break;
            
        case 1: //代码块传值
        {
            BlockTransferViewController *btvc = [BlockTransferViewController new];
            
            btvc.text = _label.text;
            
            //实现代码块行为
            btvc.transferBlock = ^(BlockTransferViewController *bt)
            {
                //利用传入的参数，取得文本框内容，赋值给标签
                _label.text = bt.textField.text;
            };
            
            
            [self.navigationController pushViewController:btvc animated:YES];
            
        }
            break;
            
        case 2: //通知传值
        {
            NotificationTransferViewController *ntvc = [NotificationTransferViewController new];
            ntvc.text = _label.text;
            
            //添加观察者的步骤不写在这个地方
            
            [self.navigationController pushViewController:ntvc animated:YES];
        }
            break;
            
        case 3: //KVO传值
        {
            KVOTransferViewController *kvotvc = [[KVOTransferViewController alloc] initWithObserver:self];
            
            kvotvc.text = _label.text;
            
            [self.navigationController pushViewController:kvotvc animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark - KVO回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:KVOTransferViewControllerTextChangedKey])
    {
        //取出更新后的文本
        NSString *newText = change[NSKeyValueChangeNewKey];
        
        //赋值给标签
        _label.text = newText;
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 实现代理传值的协议方法
- (void)controllerTextFieldDidConfirm:(DelegateTransferViewController *)dtvc
{
    //从参数获得委托人的文本框内容，显示在自己的_label上
    _label.text = dtvc.textField.text;
}


- (void)dealloc
{
    //移除通知观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
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
