//
//  ViewController.m
//  UI_11_Homework
//
//  Created by CJJMac on 15-10-10.
//  Copyright (c) 2015年 CJJMac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createButtonPressed
{
    //获取文件管理器单例对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //1.创建在Document下的cbd.dat文件
    NSString *cbdPath = [self pathInDocumentsWithFilePath:@"cbd.dat"];
    
    //假设通过某种途径获得一个文件的数据data
    NSData *cbdData = [NSData data];
    
    //用文件管理器创建这个文件
    if( [manager createFileAtPath:cbdPath contents:cbdData attributes:nil] )//这个方法的返回值表示是否创建成功
    {
        NSLog(@"cbd.dat文件创建成功！");
    }
    
    
    //2.创建Documents下的other文件夹（目录）
    NSString *otherDirPath = [self pathInDocumentsWithFilePath:@"other"];
    
    //用文件管理器创建这个目录
    //参数②：如果此文件夹的父文件夹不存在，是否自动创建，一般写YES
    if( [manager createDirectoryAtPath:otherDirPath withIntermediateDirectories:YES attributes:nil error:nil] )
    {
        NSLog(@"other目录创建成功");
    }
    
    
}

- (IBAction)moveButtonPressed
{
    //1.源文件路径
    NSString *cbdPath = [self pathInDocumentsWithFilePath:@"cbd.dat"];
    
    //2.目标文件路径
    NSString *cbdOtherPath = [self pathInDocumentsWithFilePath:@"other/cbd.dat"];
    
    //3.调用文件管理器的移动方法
    if( [[NSFileManager defaultManager] moveItemAtPath:cbdPath toPath:cbdOtherPath error:nil] )
    {
        NSLog(@"cbd.dat成功移动到other目录下");
    }
}

- (IBAction)copyButtonPressed
{
    //1.源文件路径
    NSString *cbdPath = [self pathInDocumentsWithFilePath:@"other/cbd.dat"];
    
    
    //2.目标文件路径
    NSString *bcdPath = [self pathInDocumentsWithFilePath:@"other/cbd copy.dat"];
    //在苹果系统中，/是用来划分目录层级的符号
    
    
    //3.调用文件管理器的复制方法
    if( [[NSFileManager defaultManager] copyItemAtPath:cbdPath toPath:bcdPath error:nil] )
        //第1个参数是源文件路径，第2个参数是目标文件路径
    {
        NSLog(@"cbd.dat成功复制到other/bcd.dat");
    }
    
}

- (IBAction)isExitstButtonPressed
{
    //1.获得要检查的文件路径
    NSString *cbdPath = [self pathInDocumentsWithFilePath:@"cbd.dat"];
    
    //2.用文件管理器的方法检查存在性
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //定义一个变量，标记cbd.dat是否为目录
    BOOL cbdIsDir;
    
    if( [manager fileExistsAtPath:cbdPath isDirectory:&cbdIsDir] )
        //如果路径存在则返回YES
        //isDirectory参数是一个布尔型变量的指针，表明这个路径是不是目录
    {
        NSLog(@"cbd.dat存在");
        
        if( cbdIsDir )
            NSLog(@"cbd.dat是个目录");
        else
            NSLog(@"cbd.dat不是个目录");
        
    }
    else
    {
        NSLog(@"cbd.dat不存在");
    }
    
}

- (IBAction)removeButtonPressed
{
    //假如想要删除other下的所有文件和文件夹
    NSString *otherPath = [self pathInDocumentsWithFilePath:@"other"];
    
    //1.获取other路径下的所有文件和目录
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:otherPath];
    NSLog(@"allFilesInOther:\n%@", subPaths);
    
    
    //2.遍历数组里的子路径
    for (NSString *subPath in subPaths)
    {
        //拼接出完整路径
        NSString *filePath = [self pathInDocumentsWithFilePath:
                              [@"other" stringByAppendingPathComponent:subPath]
                              ];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //删除路径
        if( [manager removeItemAtPath:filePath error:nil] )
        {
            NSLog(@"other目录下的文件成功被删除");
        }
    }
    
}




#pragma mark - 生成Documents目录下的路径的方法
- (NSString*)pathInDocumentsWithFilePath:(NSString*)path
{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:path];
    
    NSLog(@"filePath:\n%@", filePath);
    
    return filePath;
}


@end
