//
//  ArrayFileViewController.m
//  UI_11_1
//
//  Created by Ibokan_Teacher on 15/10/8.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ArrayFileViewController.h"

@interface ArrayFileViewController ()

@end

@implementation ArrayFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#pragma mark - NSArray对象持久化
    
    //1.获得完整的文件路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *arrayFilePath = [documentsPath stringByAppendingPathComponent:@"myArray.plist"];
    NSLog(@"arrayFilePath: %@", arrayFilePath);
    
    
    //2.获得一个数组
    //要让数组成功持久化，数组里的元素必须是遵守了NSCoding协议的对象
    //常用的系统数据类都符合这个要求
    NSArray *arr1 = @[@"str1", @123, [NSDate date]];
    
    
    //3.把数组写入文件
    if( ![arr1 writeToFile:arrayFilePath atomically:YES] )
    {
        NSLog(@"writing fail");
    }
    
    
    //4.从文件读取整个数组
    NSArray *arr2 = [[NSArray alloc] initWithContentsOfFile:arrayFilePath];
    
    NSLog(@"arr2: %@", arr2);
    
    
#pragma mark - NSDictionary持久化
    //原理与数组十分相似，也可以存储为plist文件
    //请自行探究
    
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
