//
//  ViewController.m
//  UI_11_2
//
//  Created by Ibokan_Teacher on 15/10/9.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ViewController.h"

//引入sqlite数据库头文件
#import <sqlite3.h>

//引入FMDatabase头文件
#import "FMDatabase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


#pragma mark - 用原生sqlite3框架操作数据库
- (IBAction)sqlite3Test
{
    //1.构建数据库文件路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *databasePath = [documentsPath stringByAppendingPathComponent:@"sql1.sqlite"];
    
    NSLog(@"databasePath: %@", databasePath);
    
    
    //2.打开数据库文件，并获得一个该数据库的引用（指针）
    
    //2.1.声明一个sqlite3空指针
    sqlite3 *database;
    
    //2.2.打开数据库文件，如果文件不存在，则会自动创建
    if( sqlite3_open([databasePath UTF8String], &database) != SQLITE_OK )
    {
        NSLog(@"数据库无法打开");
        return;
    }
    
    
    //3.创建表
    //3.1.声明一个创建表的SQL语句的C语言字符串
    const char *createSQL = "create table if not exists Users ( uid integer primary key, name text, age integer, height double, is_married boolean )";
    //3.2.执行语句
    
    //错误信息的字符串（空指针，可选）
    char *errorMessage;
    
    //真正运行SQL语句，并判断运行结果
    if ( sqlite3_exec(database, createSQL, NULL, NULL, &errorMessage) == SQLITE_ERROR )
    {
        NSLog(@"创建表错误: %s", errorMessage);
    }
    
    //4.插入记录
    //4.1.声明一个预备的SQL语句字符串
    const char *insertPrepareSQL1 = "insert into Users(name, age, height, is_married) values( ?, ?, ?, ? )";
    
    //4.2.生成真正用于执行的语句(stmt)
    sqlite3_stmt *insertStmt1;
    sqlite3_prepare_v2(database, insertPrepareSQL1, -1, &insertStmt1, NULL);
    
    //4.3.把需要代入的值绑定到stmt中
    NSString *name = @"Wong";
    NSInteger age = 40;
    double height = 1.5;
    BOOL is_married = NO;
    
    
    //绑定数据
    //参数2：表示第几个问号，序号从1开始
    sqlite3_bind_text(insertStmt1, 1, [name UTF8String], -1, NULL);
    sqlite3_bind_int64(insertStmt1, 2, age);
    sqlite3_bind_double(insertStmt1, 3, height);
    sqlite3_bind_int(insertStmt1, 4, is_married);
    
    
    //4.4.执行stmt
    if ( sqlite3_step(insertStmt1) != SQLITE_DONE )
    {
        NSLog(@"插入失败");
    }
    
    //4.5.stmt用完之后要释放资源
    sqlite3_finalize(insertStmt1);
    
    
    //5.查询记录
    //5.1.声明准备语句
    const char *selectPrepareSQL1 = "select * from Users";
    
    //5.2.生成stmt
    sqlite3_stmt *selectStmt1;
    sqlite3_prepare_v2(database, selectPrepareSQL1, -1, &selectStmt1, NULL);
    
    //5.3.绑定问号的数据
    //没有则跳过
    
    //5.4.循环执行stmt，依次取出每一条记录
    //函数返回值为SQLITE_ROW，表示查询到了一条记录
    while( sqlite3_step(selectStmt1) == SQLITE_ROW )
    {
        //每一轮循环只会得到一条记录
        //记录中的每一个键的值从stmt中提取
        //提取列的函数，列的编号从0开始
        NSInteger uid = sqlite3_column_int64(selectStmt1, 0);

        const char *name = (const char*)sqlite3_column_text(selectStmt1, 1);
        
        NSInteger age = sqlite3_column_int64(selectStmt1, 2);
        
        double height = sqlite3_column_double(selectStmt1, 3);
        
        BOOL is_married = sqlite3_column_int(selectStmt1, 4);
        
        NSLog(@"uid: %ld, name: %s, age: %ld, height: %.2f, is_married: %d", uid, name, age, height, is_married);
        
    }
    
    //5.5.释放stmt资源
    sqlite3_finalize(selectStmt1);
    
    
    //6.删除、修改记录
    //步骤与插入记录类似，只是使用delete或update语句
    
    
    //7.删除表
    //步骤与创建表类似，但使用drop table语句
    
    //8.数据库操作完毕后，关闭
    sqlite3_close(database);
    
}


#pragma mark - 使用FMDatabase
- (IBAction)fmDatabaseTest
{
    //1.构建数据库文件路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *databasePath = [documentsPath stringByAppendingPathComponent:@"sql2.sqlite"];
    
    NSLog(@"%@",databasePath);
    
    //2.通过文件路径创建数据库对象
    FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
    
    
    //3.打开数据库
    //如果数据库文件不存在则会自动创建
    if( ![database open] )
    {
        NSLog(@"数据库无法创建/打开");
        return;
    }
    
    
    //4.创建表
    //4.1.声明创建的SQL语句字符串
    NSString *createSQL = @"create table if not exists Users( uid integer primary key, name text, age integer, height double, is_married boolean )";
    
    //4.2.执行语句
    if( ![database executeUpdate:createSQL] )
    {
        NSLog(@"创建表失败");
    }
    
    
    //5.插入记录
    //5.1.声明准备语句
    NSString *insertPrepareSQL1 = @"insert into Users (name, age, height, is_married) values (?, ?, ?, ?)";
    
    //5.2.填充?参数并执行语句
    //填充的参数必须是对象
    if ( ![database executeUpdate:insertPrepareSQL1, @"Wong", @40, @1.5, @NO] )
    {
        NSLog(@"插入失败");
    }
    
    //6.查询记录
    //6.1.声明查询准备语句
    NSString *selectPrepare = @"select name, age, height from Users where name = ?";
    
    //6.2.执行语句，如有?参数，则同时代入
    //执行结果的返回值是一个FMResultSet
    FMResultSet *result = [database executeQuery:selectPrepare, @"Wong"];
    
    //6.3.从结果集对象中循环提取每一条记录
    //执行next方法后，如果取到一条记录则返回YES，如果取不到则返回NO
    while ([result next])
    {
        //每次循环只会取出一条记录
        
        //通过列的序号(从0开始)或键来获得对应的值
        
        NSString *name = [result stringForColumnIndex:0];
        
        NSInteger age = [result intForColumn:@"age"];
        
        double height = [result doubleForColumn:@"height"];
        
        NSLog(@"name: %@, age: %ld, height: %.2f", name, age, height);
        
    }
    
    
    //7.删除、修改记录
    //步骤与插入相同
    
    //8.删除表
    //步骤与创建表相同
    
    
    //9.数据库操作结束后，关闭
    [database close];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






