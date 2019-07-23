//
//  ViewController.m
//  UI_13_1
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MoneyAccout.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ALabel;

@property (weak, nonatomic) IBOutlet UILabel *BLabel;


@property (weak, nonatomic) IBOutlet UILabel *CLabel;

//一个字典映射三个Label,方便操作
@property(nonatomic,strong)NSDictionary *labels;

//一个金钱账户
//为了看出是否加线程锁的区别，这里不加线程锁，下面再加
@property (nonatomic,strong)MoneyAccout *account;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.account = [MoneyAccout new];
    self.labels = @{@"A":self.ALabel,@"B":self.BLabel,@"C":self.CLabel};
    
    
}

#pragma mark -封装一个方法用于更新label
-(void)setLabelWithDictionary:(NSDictionary*)dict
{
    //这里规定字典的内容是：
    
    //有两个key对应两个object
    
    //@"key":@"A"或者@"B"或者"C",即人名
    
    //@"text":@“对应的label要显示的文本
    
    //取出字典中的人名代表

    NSString *name = dict[@"key"];
    
    //根据这个名取出对应的标签
    UILabel *label = self.labels[name];
    
    //取出文本赋值给标签
    label.text = dict[@"text"];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 封装一个人取钱的方法
-(void)takeMoneyBy:(NSString*)name
{

   //name表示取钱的人，@”A“或@”B“或@”C“
    
    //查询账户余额
    NSInteger remainMoney = self.account.money;
    
    //构建用于显示的字符串
    NSMutableString *message = [NSMutableString stringWithFormat:@"%@查询得余额为%ld,",name,remainMoney];
  //取钱
    self.account.money -= 100;
    
    //取钱之后再查询余额
    remainMoney = self.account.money;
    
    //补充显示信息
    [message appendFormat:@"取了100后剩余%ld",remainMoney];

    //更新对应的label显示
    //由于本方法将会在子线程执行，所以更新label的操作应回到主线程中进行
    
    //构建字典
    NSDictionary *messageDict = @{@"key":name,@"text":message};
    
    [self performSelectorOnMainThread:@selector(setLabelWithDictionary:) withObject:messageDict waitUntilDone:NO];
    
}

#pragma mark - 单个用户取钱的方法（线程安全）
-(void)takeMoneysafelyBy:(NSString*)name
{
    //这样就对账户加了锁，同一时间只能有一个线程访问这个账户
    @synchronized(self.account) {
        [self takeMoneyBy:name];
        
    }
 
    
}

#pragma mark - 按钮对应的方法
- (IBAction)takeMoneyButtonPressed:(UIButton *)sender
{
    
    //每次取钱之前先保证账户有钱
    self.account.money = 1000;
    
    //用一个selector表示即将要执行的取钱方法
    SEL howToTakeMoney;
    
    if (sender.tag == 0) {
        
        //线程不安全的取钱（普通取钱）
        howToTakeMoney = @selector(takeMoneyBy:);
        
    
    
    }
    else{
    
       //线程安全的取钱
        howToTakeMoney = @selector(takeMoneysafelyBy:);
    
    }
    //模拟A,B,C三个线程同时取钱，下面用NSThread的三种创建方式，演示如何创建子线程
    
    //1.创建NSThread对象
    NSThread *aThread = [[NSThread alloc]initWithTarget:self selector:howToTakeMoney object:@"A"];
    
    [aThread start]; //开启线程对象
    
    //2.通过类方法创建子线程，创建后自动运行
    [NSThread detachNewThreadSelector:howToTakeMoney toTarget:self withObject:@"B"];
    
    //3.performSelector方法
    [self performSelector:howToTakeMoney withObject:@"C" afterDelay:0];
    
    
    
}




@end
