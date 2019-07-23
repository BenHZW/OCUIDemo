//
//  ViewController.m
//  UI_13_3
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MoneyAccout.h"

@interface ViewController ()

@property(nonatomic,strong)MoneyAccout *account;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.account = [MoneyAccout new];
    
    self.account.money = 1000;
    
    //1.获取一个子线程队列，这个队列可以自己创建，也可以获取系统提供的全局队列
    
    dispatch_queue_t takeMoneyQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //第一个参数是优先级的宏定义
    
    //2.往队列中加入异步线程
    
    //参数①：加入到哪个队列
    //参数②：这个线程要执行的代码块
    dispatch_async(takeMoneyQueue, ^{
        self.account.money -= 100;
        
        NSLog(@"剩余%ld",self.account.money);
      
        //如果要更新UI,则需要将一个线程添加到主线程队列
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            //跟新UI
        });
        
    });
    
    //3.还可以加入同步线程，同步线程将串行执行
    //dispatch_sync(<#dispatch_queue_t queue#>, <#^(void)block#>)
    
    //4.队列分组
    //4.1.创建队列分组
    dispatch_group_t  group1 = dispatch_group_create();
    
    //4.2.把一个线程放入队列中，同时把这个队列放入分组中
    dispatch_group_async(group1, takeMoneyQueue, ^{
        //线程要执行的操作
        self.account.money = 0;
        
        NSLog(@"打劫");
        
    });
   
    //4.3.释放分组
#if !__has_feature(objc_arc)
    dispatch_release(group1);
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
