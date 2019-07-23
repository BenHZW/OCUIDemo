//
//  StudentFileViewController.m
//  UI_11_1
//
//  Created by Ibokan_Teacher on 15/10/8.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "StudentFileViewController.h"
#import "Student.h"

@interface StudentFileViewController ()
{
    __weak IBOutlet UITextField *_nameTextField;
    __weak IBOutlet UITextField *_ageTextField;
}
@end

@implementation StudentFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)readOrWrite:(UIButton *)sender
{
    //文件路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *stuFilePath = [documentsPath stringByAppendingPathComponent:@"stu.plist"];
    
    NSLog(@"stuFilePath: %@", stuFilePath);
    
    
    
    switch (sender.tag)
    {
        case 0: //归档后写入文件
        {
            Student *stu = [Student new];
            stu.name = _nameTextField.text;
            stu.age = _ageTextField.text.integerValue;
            
            
            //1.完整的归档步骤
            //1.1.使用一个可变数据对象，存储归档后的数据
            NSMutableData *mData = [NSMutableData new];
            
            //1.2.创建一个归档器并指定数据放在哪个data里面
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
            
            //1.3.用归档器编码整个stu
            [archiver encodeObject:stu forKey:@"stu"];
            //这样之后，mData里面就存放了归档后的数据
            
            //还允许继续编码其他对象和数据
            
            
            //1.4.编码结束
            [archiver finishEncoding];
            
            
            //1.5.把mData的数据写入文件
            [mData writeToFile:stuFilePath atomically:YES];
            
#pragma mark - 作业：
#warning 2.归档器类提供“一句话归档”的类方法
            //[NSKeyedArchiver archiveRootObject:stu toFile:stuFilePath];
            
            
        }
            
            break;
            
            
        case 1: //读取文件并反归档为对象
        {
            //3.完整的反归档步骤
            
            //3.1.从文件中读取data
            NSData *data = [[NSData alloc] initWithContentsOfFile:stuFilePath];
            
            //3.2.创建一个反归档器，指定从哪个data中读取数据
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            
            //3.3.通过归档器解码出对象
            Student *stu = [unarchiver decodeObjectForKey:@"stu"];
            
            //如果文件中曾写入多个对象，可以继续解码
            
            
            //3.4.解码完成
            [unarchiver finishDecoding];
            
            //3.5.使用stu对象
            _nameTextField.text = stu.name;
            _ageTextField.text = [NSString stringWithFormat:@"%ld", stu.age];
          
#pragma mark - 作业：
#warning 4.反归档器类提供“一句话反归档”的类方法
            //Student *stu = [NSKeyedUnarchive unarchiveObjectWithFile:stuFilePath];
            
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
