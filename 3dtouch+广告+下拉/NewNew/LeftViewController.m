//
//  LeftViewController.m
//  New UI
//
//  Created by 3024 on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LeftViewController.h"
#import "IntoViewController.h"
#import "UIImage+UIImageExtras.h"
#import "LogViewController.h"
#import "UserInfo.h"

#define USERINFOPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"userInfo"]
@interface LeftViewController ()

{
    //创建单元格表头视图实例与显示账户的标签
    UIView *view;
    UILabel *nameLabel;
    
    //用户名
    NSString *userName;
    
    UIImageView *imageView;
    
    UserInfo *_userInfo;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //接收通知，判断登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataSource:) name:NotificationLogInfo object:nil];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"b2.png"];
    [self.view addSubview:imageview];
    
    
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
    //初始化表头
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    
    
    //昵称
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 200, 200, 50)];
    //头像
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 50, 150, 150)];
    imageView.layer.borderWidth = 2.0;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
    if (!_userInfo) {
        _isLogin = NO;
    }else
    {
        _isLogin = YES;
        userName = _userInfo.name;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -表视图代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor yellowColor];
    
    if (indexPath.row == 0) {
        if (_isLogin == YES) {
            cell.textLabel.text = @"注销";
        }else{
            cell.textLabel.text = @"登录";
        }
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"个人信息";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"设置";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.lsvc closeLeftView];
    
    //根据不同row进入不同视图
    switch (indexPath.row) {
            
        case 0:
            if (_isLogin == YES) {
                _isLogin = NO;
                //注销操作 删除文件 以下代码为删除沙盒所有文件
                NSFileManager * fileManager = [[NSFileManager alloc]init];
                NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
                
                [fileManager removeItemAtPath:filePath error:nil];
                
                [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];

                [self.tableview reloadData];
            }else{
                [self.tableview reloadData];
                LogViewController *logvc = [self.storyboard instantiateViewControllerWithIdentifier:@"logvc"];animated:YES;
                [self.nvc pushViewController:logvc animated:YES];
            }
            break;
        case 1:
            if (_isLogin == NO) {
                [self loginPlease];
            }else{
                
                [self.nvc pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"modvc"] animated:YES];
            }
            break;
        case 2:
            [self.nvc pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"setting"] animated:YES];
            break;
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 250;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //头像
    
    UIImage *avImage = [UIImage imageNamed:@"man.png"];
    if(_isLogin == NO)
    {
        avImage = [UIImage imageNamed:@"noLogin.png"];
    }
    [avImage imageByScalingToSize:CGSizeMake(100, 100)];
    imageView.image = avImage;
    [view addSubview:imageView];
    
    
    if(_isLogin == YES){
        nameLabel.text = userName;
        
    }else
    {
        nameLabel.text = @"请登陆/注册";
    }
    nameLabel.font = [UIFont systemFontOfSize:20.0f];
    nameLabel.textColor = [UIColor yellowColor];
    [view addSubview:nameLabel];
    
    return view;
}

//未登录时禁用某些功能呢
- (void)loginPlease
{
    //提示框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲爱的，赶紧登陆，登陆送智文哦" message:@"PS：智文是个美男子" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好，我马上万马鹏腾，登陆一百次！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }];
    
    [alertController addAction:ok];
    
    //以模态视图呈现
    [self presentViewController:alertController animated:YES completion:nil];
}

//登录时刷新数据源
- (void)reloadDataSource:(NSNotification*)notification
{
    
    LogViewController *lvc = notification.object;
    
    if (lvc != nil)
    {
        _isLogin = YES;
        userName = lvc.name;
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableview reloadData];
          });
    }
    else
    {
        _isLogin = NO;
        userName = @"未登录";
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
    }
    
}

- (void)dealloc
{
    //移除通知观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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