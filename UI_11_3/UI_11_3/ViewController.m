//
//  ViewController.m
//  UI_11_3
//
//  Created by Ibokan_Teacher on 15/10/10.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Student.h"
#import "Address.h"

@interface ViewController ()
{
    //对appDelegate的弱引用
    __weak AppDelegate *_app;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"documentsPath: %@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject );
    
    //获得对appDelegate的引用
    _app = [UIApplication sharedApplication].delegate;
    
    
#pragma mark - CoreData增删改查示例
    //1.增加实体
    
    //1.1.创建实体对象
    //这个操作是在托管上下文中进行的
    Student *stu1 = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_app.managedObjectContext];
    
    Address *addr1 = [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:_app.managedObjectContext];
    
    //1.2.给实体对象的属性赋值
    addr1.country = @"China";
    addr1.city = @"Guangzhou";
    
    stu1.name = @"Choy";
    stu1.age = @18;
    stu1.address = addr1;
    
    //1.3.保存上下文（将数据写入数据库）
    NSError *err;
    
    if( ![_app.managedObjectContext save:&err] )
    {
        NSLog(@"保存上下文失败: %@", err);
    }
    
    //也可以执行这句，保存上下文
    //[_app saveContext];
    
    
    
    //2.查询实体
    
    //2.1.创建查询请求
    NSFetchRequest *fetchRequest1 = [NSFetchRequest new];
    
    //2.2.创建实体描述器，指明要查询哪些实体
    NSEntityDescription *studentDescription1 = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:_app.managedObjectContext];
    
    //把实体描述器赋值给查询请求
    fetchRequest1.entity = studentDescription1;
    
    
    //2.3.可选步骤：设定谓词，限定查找条件
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"age > 10"];
    fetchRequest1.predicate = predicate1;
    
    //2.4.可选步骤：设定排序描述器，对查询结果进行排序
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *ageDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    
    fetchRequest1.sortDescriptors = @[nameDescriptor, ageDescriptor];
    
    
    
    
    //2.5.执行查询请求
    //执行后返回一个数组，里面存放查询得到的实体对象
    NSArray *result1 = [_app.managedObjectContext executeFetchRequest:fetchRequest1 error:nil];
    
    //从数组中取出实体对象
    for (Student *stu in result1)
    {
        NSLog(@"stu: %@", stu);
    }
    
    
    
    //3.删除实体
    //3.1.在删除之前先要设法从数据库查询的步骤中获得这个实体
    Student *stuToBeDelete = result1.firstObject;
    
    //3.2.执行删除操作
    [_app.managedObjectContext deleteObject:stuToBeDelete];
    
    //3.3.保存上下文
    [_app saveContext];
    
    
    //尝试查询Address实体，还有结果吗？
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







