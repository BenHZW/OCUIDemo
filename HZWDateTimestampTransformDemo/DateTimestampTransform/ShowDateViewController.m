//
//  ShowDateViewController.m
//  DateTimestampTransform
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "ShowDateViewController.h"

@interface ShowDateViewController ()
{

    NSDateFormatter *_formatter;
    UITextField *_textField1;
    UITextField *_textField2;
    UITextField *_textField3;
    UITextField *_textField4;
}
@end

@implementation ShowDateViewController

- (void)viewDidLoad
{
     [super viewDidLoad];
     //设置时间显示的格式
     _formatter= [[NSDateFormatter alloc] init];
     _formatter.dateStyle = NSDateFormatterMediumStyle;
     _formatter.timeStyle = NSDateFormatterShortStyle;
     _formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
     NSTimeZone *timeZone = [NSTimeZone localTimeZone];
     _formatter.timeZone = timeZone;
    
    
    _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, 180, 100)];
    _textField1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textField1];
    
    _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(220,20, 180, 100)];
    _textField2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textField2];
    
    
    _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 180, 100)];
    _textField3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textField3];
    
    _textField4 = [[UITextField alloc] initWithFrame:CGRectMake(220, 200, 180, 100)];
    _textField4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textField4];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(110, 130, 150, 60)];
    [button1 setTitle:@"date转时间戳" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor brownColor];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(110, 320, 150, 60)];
    [button2 setTitle:@"时间轴转date" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor brownColor];
    [self.view addSubview:button2];
    
    _textField2.enabled = NO;
    _textField4.enabled = NO;
    
    [button1 addTarget:self action:@selector(dateTransformTimestamp) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(TimestampTransformDate) forControlEvents:UIControlEventTouchUpInside];
    
    //textField1 和textField3可以改变相应的数据从而实现不同数据之间的转换
     _textField1.text = [_formatter stringFromDate:[[NSDate alloc]init]];
     _textField3.text = @"1296035591";
}

#pragma mark - date转时间戳
- (void)dateTransformTimestamp
{
    NSDate *currentData = [_formatter dateFromString:_textField1.text];
    //时间转时间戳的方法
    NSString *dateNowTimestamp = [NSString stringWithFormat:@"%ld",(long)(currentData.timeIntervalSince1970)];
    _textField2.text = dateNowTimestamp;
}

#pragma mark - 时间戳转date
- (void)TimestampTransformDate
{
    //时间戳转date的方法
    NSInteger i1 =  [_textField3.text integerValue];
    NSDate *confromTimestamp = [NSDate dateWithTimeIntervalSince1970:i1];
    //格式化
   _textField4.text = [_formatter stringFromDate:confromTimestamp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
