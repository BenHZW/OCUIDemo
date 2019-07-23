//
//  StringFileViewController.m
//  UI_11_1
//
//  Created by Ibokan_Teacher on 15/10/8.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "StringFileViewController.h"

@interface StringFileViewController ()
{
    __weak IBOutlet UITextView *_textView;
    
}
@end

@implementation StringFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)readOrWrite:(UIButton *)sender
{
    //1.构造文本文件的路径
    //1.1.获取Documents路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    //1.2.拼接出完整的文本文件路径
    NSString *textFilePath = [documentsPath stringByAppendingPathComponent:@"myText.txt"];
    
    NSLog(@"textFilePath: %@", textFilePath);
    
    
    
    //2.读/写文件
    switch (sender.tag)
    {
        case 0: //写入文件
        {
            //把文本框上的文本（字符串）写入文件
            NSString *text = _textView.text;
            
            
            //声明一个错误对象的空指针(可选)
            NSError *error;
            
            //如果写入不成功，则返回NO，且错误对象会变为非空
            if( ![text writeToFile:textFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error] )
            {
                //处理错误
                NSLog(@"error: %@", error);
            }
            
        }
            break;
            
            
        case 1: //读文件
        {
            //从文本文件读取字符串，显示在文本框上
            
            //错误对象空指针
            NSError *error;
            
            //从文件读取来创建字符串
            NSString *text = [[NSString alloc] initWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:&error];
            
            //如果发生错误则可能读取失败
            if (error)
            {
                //处理错误
                NSLog(@"error: %@", error);
            }
            else
            {
                //没有错误
                _textView.text = text;
            }
            
        }
            break;
            
            
        default:
            break;
    }
    
}




- (void)didReceiveMemoryWarning {
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
