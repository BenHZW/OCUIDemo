//
//  SearchViewController.m
//  HZWSQLDemo
//
//  Created by Gemll on 16/1/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchViewController.h"
#import "SendViewController.h"
#import "FMDatabase.h"
@interface SearchViewController()
{
    FMDatabase *_searchDb;
    
    //姓名
    UITextField *nameTextField;
    
    //年龄
    UILabel * _ageTextLabel;
    
    UILabel *_heightlabel;
    
    UILabel *_is_maleLabel;
    
    
}
@end

@implementation SearchViewController

-(void)viewDidLoad
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
 
    
    _searchDb = database;
    
    //姓名
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 60, 60)];
    
    namelabel.text = @"姓名";
    namelabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: namelabel];
    
    //姓名label
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 80, 60)];
    
    
    nameTextField.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:nameTextField];
    
    
    
    //回收键盘按钮
    /*
    UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [returnButton setTitle:@"return" forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor grayColor];
    [returnButton addTarget:nameTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    
    nameTextField.inputAccessoryView = returnButton;
    */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backReturn:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    
    //年龄
    UILabel *agelabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 160, 60, 60)];
    
    agelabel.text = @"年龄";
    agelabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: agelabel];
    
    //年龄label
    _ageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(330, 160, 80, 60)];
    
    _ageTextLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_ageTextLabel];
    
    
    
    //身高
    UILabel *heightlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 60, 60)];
    
    heightlabel.text = @"身高";
    heightlabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: heightlabel];
    
    //身高label
    _heightlabel= [[UILabel alloc] initWithFrame:CGRectMake(100, 260, 80, 60)];
    
    
   _heightlabel.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:_heightlabel];
    
  
    //性别
    UILabel *sexlabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 260, 60, 60)];
    
    sexlabel.text = @"性别";
    sexlabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview: sexlabel];
    
    //性别label
     _is_maleLabel = [[UILabel alloc] initWithFrame:CGRectMake(330, 260, 80, 60)];
    
    _is_maleLabel.backgroundColor = [UIColor greenColor];

    [self.view addSubview:_is_maleLabel];
    
    //查找按钮
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 360, 100, 100)];
    
    searchButton.backgroundColor = [UIColor redColor];
    
    [searchButton setTitle:@"查找" forState:UIControlStateNormal];
    
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:searchButton];
    
    [searchButton addTarget:self action:@selector(searchButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
    
    
}



#pragma mark - 回收键盘
- (void)backReturn:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
    
    
}

#pragma mark - 查

//按下查询按钮
- (void)searchButtonTouchUp
{
    NSLog(@"正在查找");
    NSString *selectPrepare = @"select * from Users where name = ?";
    if ([_searchDb open])
    {
        FMResultSet *result = [_searchDb executeQuery:selectPrepare,nameTextField.text];
    
    
        if (result.next)
        {
        
            NSString *name = [result stringForColumnIndex:0];
        
            NSString *age = [result stringForColumn:@"age"];
        
            NSString *height = [result stringForColumn:@"height"];
        
            NSString *is_male = [result stringForColumn:@"is_male"];
        
            NSLog(@"name: %@, age: %@,height: %@,is_male: %@", name,age, height,is_male);
            
            
            nameTextField.text = name;
            
            _ageTextLabel.text = age;
            
            _heightlabel.text = height;
            
            _is_maleLabel.text = is_male;
        }
    }
    else
    {
        NSLog(@"打开失败");
    }
    [_searchDb close];
    
    
   
}



@end
