//
//  LogViewController.m
//  New UI
//
//  Created by gdm on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LogViewController.h"
#define login_web @"http://knews.sinaapp.com/api-2/login.api-2.php?act=login"
#import "MyPageViewController.h"
#import "UserInfo.h"
NSString *const NotificationLogInfo = @"NotificationLogInfo";

@interface LogViewController ()

{
    BOOL _isOK;
}
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登陆";
    
    self.userName.text = self.name;
    
    self.passWord.text = self.password;
    
    _isOK = NO;
    
}
- (IBAction)loginPress:(id)sender {
    //登陆 参数自行带入
    [self requestUrl:login_web param:[NSString stringWithFormat:@"<user><name>%@</name><password>%@</password></user>",_userName.text,_passWord.text]];
    
}
//登陆成功 跳转
-(void)loginOK
{
    dispatch_async(dispatch_get_main_queue(), ^{
    if (_isOK == YES)
    {
        MyPageViewController *mpvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mainPagevc"];
        
        [self.navigationController pushViewController:mpvc animated:YES];

    }else
    {
        //提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲爱的，账号或密码错误，再次狂登，登陆送智文哦" message:@"PS：智文是个美男子" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好，我马上万马鹏腾，登陆一百次！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
        }];
        
        [alertController addAction:ok];
        
        //以模态视图呈现
        [self presentViewController:alertController animated:YES completion:nil];
    }
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestUrl:(NSString*)url_string param:(NSString*)param
{
    //同步
    
    //创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"post";//设置请求方法
    
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置请求头
    [request addValue:@"xml" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    //4.task
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"datastring:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response:%@",response);
        NSLog(@"error:%@",error);
       
        
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"string:%@",string);
        if ([string rangeOfString:@"name"].location != NSNotFound)
        {
            NSDictionary *dataDic_string = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dataDic = dataDic_string[@"data"];
            NSString *name = dataDic[@"name"];
            NSString *password = dataDic[@"password"];
            NSString *email = dataDic[@"email"];
            NSString *sex = dataDic[@"sex"];
            NSInteger age = [dataDic[@"age"] integerValue];
            
            _isOK = YES;
            self.userInfo = [UserInfo userInfoWithName:name sex:sex age:age email:email passWord:password];
            NSString *userInfoPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"userInfo"];
            [NSKeyedArchiver archiveRootObject:self.userInfo toFile:userInfoPath];
            self.name = self.userInfo.name;
            self.password = self.userInfo.passWord;
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLogInfo object:self userInfo:nil];
            
        }else
        {
            NSLog(@"登陆失败");
            _isOK = NO;
        }
        
        [self loginOK];
    }];
    
    [task resume];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
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
