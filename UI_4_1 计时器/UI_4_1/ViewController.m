//
//  ViewController.m
//  UI_4_1
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 ios22. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    //会变的“父视图”
    UIView *_v1;
    
    //增量实例变量
    NSInteger _increment;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark -------------------------
    //做简单的测试，可以将控件添加在window上
    //如果有代理方法或者action，也可以直接添加在这个appdelegate里面
    
    //1.初始化“父视图”
    _v1 = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 150, 150)];
    
    [self.view addSubview:_v1];
    
    _v1.backgroundColor = [UIColor greenColor];
    
    
    //当_v1尺寸发生改变时，是否调整他的子视图的frame，默认是YES
    //_v1.autoresizesSubviews = YES;
    
    
    
    //2.用一个定时器让_v1动起来
    //改在开关控制的方法中添加
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    
    
    
    
    //3.创建_v1里面的子视图v2
    //这个尺寸是以父视图还没变化的时候为基准的
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    
    //center属性，指定本视图的中心位于父视图的所标点
    v2.center = CGPointMake(75, 75);
    
    [_v1 addSubview:v2];
    
    v2.backgroundColor = [UIColor redColor];
    
    
    //设置子视图随父视图变化而调整的模式
    v2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    
    
    //------
    //读取上次存储的_v1的frame值
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *v1FrameValue = [defaults objectForKey:@"v1frame"];
    
    //防止程序首次运行时没有获得存储数据
    if (v1FrameValue != nil)
        _v1.frame = CGRectFromString(v1FrameValue);
    //------
    
    
    
    //4.添加开关控件，控制定时器开关
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(30, 300, 0, 0)];
    [self.view addSubview:aSwitch];
    
    [aSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //读取上次存储的开关值
    aSwitch.on = [defaults boolForKey:@"aSwitch.isOn"];
    
    //用代码设置按钮开关并不会触发响应方法，但可以通过代码模拟触发响应方法
    [self switchValueChanged:aSwitch];
    
    
    //5.读取上次存储的增量
    NSInteger lastIncrement = [defaults integerForKey:@"increment"];
    if (lastIncrement == 0)
    {
        _increment = 1;
    }
    else
    {
        _increment = lastIncrement;
    }
    
    
    
    
#pragma mark -------------------------
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 开关值变化响应的方法
- (void)switchValueChanged:(UISwitch*)aSwtich
{
    static NSTimer *timer;
    
    //判断开关值
    if (aSwtich.isOn)
    {
        //重新创建并自动启动
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    }
    else
    {
        //停止计时器，并释放对象
        [timer invalidate];
        timer = nil;
    }
    
    
    //用NSUserDefaults存储开关状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:aSwtich.isOn forKey:@"aSwitch.isOn"];
    
}


#pragma mark - 定时器定时执行的方法
- (void)timerTick:(NSTimer*)timer
{
    CGRect v1Frame = _v1.frame;
    
    //判断v1的frame的宽度
    if ( CGRectGetWidth(v1Frame) == 150 )
    {
        _increment = 1;
    }
    else if (CGRectGetWidth(v1Frame) == 250)
    {
        _increment = -1;
    }
    
    
    //使用增量改变v1的frame
    v1Frame.size.width += _increment;
    v1Frame.size.height += _increment;
    
    _v1.frame = v1Frame;
    
}

- (void)dealloc
{
    //用NSUserDefaults保存轻量的配置数据
    //(这是“持久化”的一种形式)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //往defaults里存数据就像字典一样
    //但不同的是，它还允许直接存放基本数据类型
    
    //比如这里存放_v1.frame
    [defaults setObject:NSStringFromCGRect(_v1.frame) forKey:@"v1frame"];
    //存放“增量”
    [defaults setInteger:_increment forKey:@"increment"];
}

@end
