//
//  SendViewController.m
//  HZWSQLDemo
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SendViewController.h"
#import "ReceiveViewController.h"
#import "ChangeViewController.h"
#import "FMDatabase.h"
#import "SearchViewController.h"
#import "DeleteViewController.h"
@interface SendViewController ()
{
  FMDatabase *_db;

}
@end

@implementation SendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //打开数据库并且创建表
    //1.构建数据库文件路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *databasePath = [documentsPath stringByAppendingPathComponent:@"sql3.sqlite"];
    
    NSLog(@"---------%@",databasePath);
    //2.通过文件路径创建数据库对象
    FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
    
    //3.打开数据库
    //如果数据库文件不存在则会自动创建
    if (![database open])
    {
        NSLog(@"数据库无法创建/打开");
        return;
    }
    else
    {
        NSLog(@"数据库创建成功");
    }

    //4.创
    NSString *creatSQL = @"create table if not exists Users(name text,age text, height text, is_male text)";
    BOOL creatSQLResult = [database executeUpdate:creatSQL];
    if (creatSQLResult == 0)
    {
        NSLog(@"创表失败");
    }
    
    else
    {
        NSLog(@"创表成功");
    }
    
    _db = database;
    
    //textView创建
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 70, 300, 550)];
    
    textView.editable = NO;
    
    textView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:textView];
    
    //增加数据的按钮
    UIButton *insertButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 650, 80, 50)];
    
    insertButton.backgroundColor = [UIColor redColor];
    [insertButton setTitle:@"增加" forState:UIControlStateNormal];
    
    [insertButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:insertButton];
    
    [insertButton addTarget:self action:@selector(insertButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
    
    //删除数据的按钮
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 650, 80, 50)];
    
    deleteButton.backgroundColor = [UIColor redColor];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    
    [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:deleteButton];
    
    [deleteButton addTarget:self action:@selector(deleteButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
    
    //更改数据的按钮
    UIButton *changeButton = [[UIButton alloc] initWithFrame:CGRectMake(210, 650, 80, 50)];
    
    changeButton.backgroundColor = [UIColor redColor];
    [changeButton setTitle:@"更改" forState:UIControlStateNormal];
    
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:changeButton];
    
    [changeButton addTarget:self action:@selector(changeButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
    
    //查找数据的按钮
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(310, 650, 80, 50)];
    
    searchButton.backgroundColor = [UIColor redColor];
    [searchButton setTitle:@"查找" forState:UIControlStateNormal];
    
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:searchButton];
    
    [searchButton addTarget:self action:@selector(searchButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"重新显示－－－－－－－－－－－－");
    
}

//增加按钮触发
-(void)insertButtonTouchUp
{
    
    ReceiveViewController *receiveViewController = [ReceiveViewController new];
    
    [self.navigationController pushViewController:receiveViewController animated:YES];
    

}



//删除按钮触发
-(void)deleteButtonTouchUp
{
    DeleteViewController *delteViewController = [DeleteViewController new];
    
    [self.navigationController pushViewController: delteViewController animated:YES];
    
}

//更改按钮触发
-(void)changeButtonTouchUp
{
    ChangeViewController *changeViewController = [ChangeViewController new];
    
    [self.navigationController pushViewController:changeViewController animated:YES];
    
 
}

//查找按钮触发
-(void)searchButtonTouchUp
{
    SearchViewController *searchViewController = [SearchViewController new];
    
    [self.navigationController pushViewController:searchViewController animated:YES];
    
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
