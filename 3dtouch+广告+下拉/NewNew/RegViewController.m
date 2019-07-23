//
//  RegViewController.m
//  New UI
//
//  Created by gdm on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#define USER_REG @"http://knews.sinaapp.com/api-2/register.api.php?act=register"

#import "RegViewController.h"
#import "LogViewController.h"
#import "UserInfo.h"

@interface RegViewController ()
{
    NSData *_recieveData;
}

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *email;
@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)regPress:(id)sender {
    //注册按钮
    
    NSString *register_url_string = [NSString stringWithFormat:@"<user><name>%@</name><icon></icon><password>%@</password><email>%@</email><sex>%@</sex><age>%ld</age><birthday/><regtime/><lastlogintime/></user>",self.name.text,self.passWord.text,self.email.text,self.sex.text,self.age.text.integerValue];
    
    //注册完毕，跳转页面
    
    [self requestUrl:USER_REG param:register_url_string];

    
    
    
    
    
    
    //[self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}


-(void)requestUrl:(NSString*)url_string param:(NSString*)param
{
    //创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"post";//设置请求方法
    
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置请求头
    [request addValue:@"xml" forHTTPHeaderField:@"Content-Type"];
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //[_activity startAnimating];
    //发送请求
    
    //4.task
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"datastr:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response:%@",response);
        NSLog(@"error:%@",error);
        
        _recieveData = [NSData dataWithData:data];
        
        NSLog(@"/////// %@", [[NSString alloc]initWithData:_recieveData encoding:NSUTF8StringEncoding]);
    
        //重新加载数据
       // _dataSourse = [NSMutableArray array];
        //NSString* comment_list_url_string = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/register.api.php?act=register"];
        
        //解析数据
        //[self getNewsDataWithUrl_string:comment_list_url_string];
        
        dispatch_async(mainQueue, ^{
            
            //更新UI
           // [_activity stopAnimating];
            //[self.tableView reloadData];
            NSString *string = [[NSString alloc]initWithData:_recieveData encoding:NSUTF8StringEncoding];
            
            if (([string rangeOfString:@"success"].location != NSNotFound) && ([string rangeOfString:@"注册用户成功" ].location != NSNotFound))
            {
                UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                LogViewController *lvc = [mainStory instantiateViewControllerWithIdentifier:@"logvc"];
                
                lvc.name = self.name.text;
                
                NSLog(@"name: %@", self.name.text);
                
                lvc.password = self.passWord.text;
                
                lvc.userInfo = [UserInfo userInfoWithName:self.name.text sex:self.sex.text age:self.age.text.integerValue email:self.email.text passWord:self.passWord.text];
                
                
                [self.navigationController pushViewController:lvc animated:YES];
            }
        });
        
    }];
    
    //5.执行
    [task resume];
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
