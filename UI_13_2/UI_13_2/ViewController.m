//
//  ViewController.m
//  UI_13_2
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MoneyAccout.h"
#import "TakeMoneyOperation.h"
@interface ViewController ()

@property(nonatomic,strong)MoneyAccout *account;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.account =[MoneyAccout new];
    self.account.money = 1000;
    
    //1.每创建一个Operation对象就代表一个线程
    TakeMoneyOperation *aOperation = [TakeMoneyOperation new];
    
    aOperation.moneyTaker = @"A";
    aOperation.account = self.account;
    //这时候还没有被执行
    
    TakeMoneyOperation *bOperation = [TakeMoneyOperation new];
    
    
    bOperation.moneyTaker = @"B";
    
    bOperation.account = self.account;
   
    //这是通过代码块定义操作的Operation的子类
    NSBlockOperation * cOperation = [NSBlockOperation blockOperationWithBlock:^{
        //查询余额
        NSInteger remainMoney = self.account.money;
        
        //信息
        NSMutableString * message = [NSMutableString stringWithFormat:@"C查询余额%ld",remainMoney];
        
        //取钱
        self.account.money -= 100;
        
        //信息
        [message appendFormat:@"取出100剩余%ld",self.account.money];
        
        //打印
        NSLog(@"%@",message);
        
    
        
        
        
    }];
    
    //2.创建Operation队列，Operation只有在队列中才能跑
    
    //这样创建出来的就是子线程队列
    
    NSOperationQueue *takeMoneyQueue = [NSOperationQueue new];
    
    //2.1.可以设置最大并行数
    takeMoneyQueue.maxConcurrentOperationCount = 1;
    
    //2.2设置Operation之间的依赖关系
    //[bOperation addDependency:aOperation];
    //[cOperation addDependency:bOperation];
    
    //3.把Operation对象放入队列中
    [takeMoneyQueue addOperation:bOperation];
    [takeMoneyQueue addOperation:aOperation];
    [takeMoneyQueue addOperation:cOperation];
    //这样，这些Operation就会自动开始执行
    //是在三个子线程中执行
    
  
    //4.如果涉及更新UI的操作，就要创建包含这些操作的Operation对象，并把它放入主线程队列中
    //获得主线程队列的方法是
    //NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //当Operation放入主线程队列中，其操作就是在主线程中执行的
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
