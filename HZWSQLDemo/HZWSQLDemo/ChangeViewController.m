//
//  ChangeViewController.m
//  HZWSQLDemo
//
//  Created by Gemll on 16/1/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChangeViewController.h"
#import "FMDatabase.h"
#import "SendViewController.h"
@interface ChangeViewController()
{
    FMDatabase *_changeDb;
    
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


@implementation ChangeViewController

- (void)viewDidLoad
{
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


    _changeDb = database;
    
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
    
    //self.willChangeName = _nameTextField.text;
    
    //回收键盘按钮
    /*
    UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [returnButton setTitle:@"return" forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor grayColor];
    [returnButton addTarget:_nameTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    
    _nameTextField.inputAccessoryView = returnButton;
    */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardReturn:)];
    tap.cancelsTouchesInView = YES;
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
    
    //self.willChangeAge = _ageTextField.text;
    
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
    
    //self.willChangeHeight = _heightTextField.text;
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
    
    //self.willChangeIs_male = _sexTextField.text;
    
    //确认按钮
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 360, 100, 100)];
    
    confirmButton.backgroundColor = [UIColor redColor];
    
    [confirmButton setTitle:@"更改" forState:UIControlStateNormal];
    
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:confirmButton];
    
    [confirmButton addTarget:self action:@selector(confirmButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
    
    //查找按钮
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 360, 100, 100)];
    
    searchButton.backgroundColor = [UIColor redColor];
    
    [searchButton setTitle:@"查找" forState:UIControlStateNormal];
    
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:searchButton];
    
    [searchButton addTarget:self action:@selector(searchButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
  
}

#pragma mark - 回收键盘
- (void)keyBoardReturn:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}


#pragma mark - 改
//确认键按下触发事件
- (void)confirmButtonTouchUp
{
    
    
    
    if ([_changeDb open])
    {
        //多参数改值
     BOOL changeResult = [_changeDb executeUpdate:@"update Users set age = ?,height = ?,is_male = ? where name = ?",_ageTextField.text,_heightTextField.text, _sexTextField.text,_nameTextField.text];
    //[db executeUpdate:@"UPDATE User SET Name = ? WHERE Name = ? ",@"老婆",@"宝贝"];
        //BOOL changeResult = [_changeDb executeUpdate:changeSQL,_ageTextField.text,_heightTextField.text, _sexTextField.text ,_nameTextField.text];
    
        if ( changeResult == 0)
        {
            NSLog(@"更改失败");
        }
    
        else
        {
            NSLog(@"更改成功");
        }
    }
    else
    {
        NSLog(@"打开数据库失败");
    }
    [_changeDb close];

    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[SendViewController class]])
        {
            SendViewController *obj1 = obj;
            
            obj1.receiveName  = _nameTextField.text;
            obj1.receiveAge   = _ageTextField.text;
            obj1.receiveHeight = _heightTextField.text;
            obj1.receiveIs_male = _sexTextField.text;
            
            [self.navigationController popToViewController:obj1 animated:YES];
        }
    }];

    
}

#pragma mark - 查询更改按钮
//查找键按下触发事件
- (void)searchButtonTouchUp
{
    NSLog(@"按下查找按钮");
    
    NSString *selectPrepare = @"select name from Users where name = ?";
    
    FMResultSet *result = [_changeDb executeQuery:selectPrepare,_nameTextField.text];
    
    
    if (result.next)
    {
       
        NSString *name = [result stringForColumnIndex:0];
        
        NSString *age = [result stringForColumn:@"age"];
        
        NSString *height = [result stringForColumn:@"height"];
        
        NSString *is_male = [result stringForColumn:@"is_male"];
        
        NSLog(@"name: %@, age: %@,height: %@,is_male: %@", name,age, height,is_male);
        
        _nameTextField.text = name;
        
        _ageTextField.text = age;
        
        _heightTextField.text = height;
        
        _sexTextField.text = is_male;
    }
    
}

@end
