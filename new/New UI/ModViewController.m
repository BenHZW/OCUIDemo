//
//  ModViewController.m
//  New UI
//
//  Created by gdm on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ModViewController.h"
#import "UserInfo.h"
#define USERINFOPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"userInfo"]
#define MODIFYUSERINFO @"http://knews.sinaapp.com/api-2/register.api.php?act=modify"

@interface ModViewController ()

{
    NSData *_data;
    
    __weak IBOutlet UITextView *_textField;
    __weak IBOutlet UIButton *_button;
}


@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *email;
@end

@implementation ModViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    
   // NSString *userInfoPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"userInfo"];
    
    UserInfo *user = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
     _textField.selectable = NO;
    
    
    if (user)
    {
        self.name.text = user.name;
        self.passWord.text = user.passWord;
        self.sex.text = user.sex;
        self.age.text = [NSString stringWithFormat:@"%ld", user.age];
        
        self.email.text = user.email;
    }
    
    
    
}


- (IBAction)CancelThead:(id)sender {
    
    _textField.hidden = YES;
    _button.hidden = YES;
    

    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)modPress:(id)sender {
    //修改、保存信息按钮
    
    //提交数据格式并将用户信息对象归档
    
    //拼接提交数据格式
    
    NSString *mod_url_string = [NSString stringWithFormat:@"<user><name>%@</name><icon></icon><password>%@</password><email>%@</email><sex>%@</sex><age>%ld</age><birthday/><regtime/><lastlogintime/></user>", self.name.text,self.passWord.text,self.email.text,self.sex.text,self.age.text.integerValue];
    
    [self requestUrl:MODIFYUSERINFO param:mod_url_string];
    
    UserInfo *userInfo = userInfo = [UserInfo userInfoWithName:self.name.text sex:self.sex.text age:self.age.text.integerValue email:self.email.text passWord:self.passWord.text];
    
    [NSKeyedArchiver archiveRootObject:userInfo toFile:USERINFOPATH];

    
   // ModViewController *mvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"modvc"];
    
   // [self.navigationController pushViewController:mvc animated:YES];
    
    //归档对象
    
        
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)requestUrl:(NSString*)url_string param:(NSString*)param
{
    //创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"post";//设置请求方法
    
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置请求头
    [request addValue:@"xml" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    //4.task
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"datastr:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response:%@",response);
        NSLog(@"error:%@",error);
       // _data = [NSData dataWithData:data];
        
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (([string rangeOfString:@"success"].location != NSNotFound) && ([string rangeOfString:@"修改信息成功" ].location != NSNotFound)) {
            
            
            UserInfo *userInfo = userInfo = [UserInfo userInfoWithName:self.name.text sex:self.sex.text age:self.age.text.integerValue email:self.email.text passWord:self.passWord.text];
            
            [NSKeyedArchiver archiveRootObject:userInfo toFile:USERINFOPATH];
            
            
            
            
        }

            
        
    }];
    
    //5.执行
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
