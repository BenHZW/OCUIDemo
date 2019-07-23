//
//  TakeMoneyOperation.m
//  UI_13_2
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TakeMoneyOperation.h"

@implementation TakeMoneyOperation

//重写main方法
-(void)main
{

  //这里面包含的就是这个线程的操作
    
  //查询余额
    NSInteger remainMoney = self.account.money;
    
    //构建信息字符
    NSMutableString *message = [NSMutableString stringWithFormat:@"%@查得余额%ld",self.moneyTaker,remainMoney];
    self.account.money -= 100;
    
    //查询余额
    remainMoney = self.account.money;
    
    //补充信息
    [message appendFormat:@",取出100剩余%ld",remainMoney];
    
    //打印
    NSLog(@"%@",message);
    
    
    //4.如果涉及更新UI的操作，就要创建包含这些操作的Operation对象，并把它放入主线程队列中
    //获得主线程队列的方法是
    //NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //当Operation放入主线程队列中，其操作就是在主线程中执行的
    
}



@end
