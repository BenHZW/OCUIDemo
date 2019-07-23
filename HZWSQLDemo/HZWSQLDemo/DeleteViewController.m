//
//  DeleteViewController.m
//  HZWSQLDemo
//
//  Created by Gemll on 16/1/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DeleteViewController.h"
#import "FMDatabase.h"
#import "SendViewController.h"
@interface DeleteViewController ()
{
    FMDatabase *_deleteDb;
    
    //姓名
    UITextField *_nameTextField;
    
    //年龄
    UITextField *_ageTextField;
    
    //高度
    UITextField *_heightTextField;
    
    //性别
    UITextField *_sexTextField;
}
@end

@implementation DeleteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *databasePath = [documentsPath stringByAppendingPathComponent:@"sql3.sqlite"];
    
    //2.通过文件路径创建数据库对象
    FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
    
    //3.打开数据库
    //如果数据库文件不存在则会自动创建
    if (![database open])
    {
        NSLog(@"数据库无法创建/打开");
        return;
    }
 
    
    
    _deleteDb = database;
    
    //姓名
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 60, 60)];
    
    namelabel.text = @"姓名";
    namelabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: namelabel];
    
    //姓名文本框
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 80, 60)];
    
    _nameTextField.placeholder = @"name";
    
    _nameTextField.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:_nameTextField];
    
    
    //回收键盘按钮
    /*
    UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [returnButton setTitle:@"return" forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor grayColor];
    [returnButton addTarget:_nameTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    
    _nameTextField.inputAccessoryView = returnButton;
    */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    //年龄
    UILabel *agelabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 160, 60, 60)];
    
    agelabel.text = @"年龄";
    agelabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: agelabel];
    
    //年龄文本框
    _ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(330, 160, 80, 60)];
    
    _ageTextField.placeholder = @"age";
    
    _ageTextField.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_ageTextField];
    
//    [returnButton addTarget:_ageTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
//    
//    _ageTextField.inputAccessoryView = returnButton;
    
    
    //身高
    UILabel *heightlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 60, 60)];
    
    heightlabel.text = @"身高";
    heightlabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: heightlabel];
    
    //身高文本框
    _heightTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 260, 80, 60)];
    
    _heightTextField.placeholder = @"height";
    
    _heightTextField.backgroundColor = [UIColor greenColor];
    
//    [returnButton addTarget:_heightTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
//    
//    _heightTextField.inputAccessoryView = returnButton;
    [self.view addSubview:_heightTextField];
    
    
    
    //性别
    UILabel *sexlabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 260, 60, 60)];
    
    sexlabel.text = @"性别";
    sexlabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: sexlabel];
    
    //性别文本框
    _sexTextField = [[UITextField alloc] initWithFrame:CGRectMake(330, 260, 80, 60)];
    
    _sexTextField.placeholder = @"sex";
    
    _sexTextField.backgroundColor = [UIColor greenColor];
    
//    [returnButton addTarget:_sexTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
//    
//    _sexTextField.inputAccessoryView = returnButton;
    [self.view addSubview:_sexTextField];
    
    
    
    //删除按钮
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 360, 100, 100)];
    
    confirmButton.backgroundColor = [UIColor redColor];
    
    [confirmButton setTitle:@"删除" forState:UIControlStateNormal];
    
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:confirmButton];
    
    [confirmButton addTarget:self action:@selector(deleteButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 回收键盘
- (void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];

}

#pragma mark - 删
-(void)deleteButtonTouchUp
{
    NSString *deleteSQL = @"delete from Users Where name = ?";
     if([_deleteDb open])
  {
     
    BOOL cancelResult = [_deleteDb executeUpdate:deleteSQL,_nameTextField.text];
  
        
    if (cancelResult== 0)
    {
        NSLog(@"删除数据失败");
    }
    
    else
    {
        NSLog(@"删除数据成功");
        
    }
   }
     else
     {
         NSLog(@"打开数据库失败");
     }
    [_deleteDb close];
    
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[SendViewController class]])
        {
            SendViewController *obj1 = obj;
        
            
            [self.navigationController popToViewController:obj1 animated:YES];
        }
    }];

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
