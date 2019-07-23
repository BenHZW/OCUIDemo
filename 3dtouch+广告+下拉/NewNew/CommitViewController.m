
//
//  VideoCommitViewController.m
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CommitViewController.h"
#import "GDataXMLNode.h"
#import "CommentItem.h"
#import "HRChatCell.h"
#import "UserInfo.h"
#import "SettingTableViewController.h"
#import "WXApi.h"

#define comment_add @"http://knews.sinaapp.com/api-2/comment.api.php?act=add"
#define comment_del @"http://knews.sinaapp.com/api-2/comment.api.php?act=del&"
#define USERINFOPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"userInfo"]
@interface CommitViewController ()<UITextFieldDelegate>
{
    //数据源
    NSMutableArray *_dataSourse;
    UserInfo *_userInfo;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation CommitViewController
static NSString * const RCellIdentifier = @"HRChatCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(settingNightMode:) name:SettingNightMode object:nil];
    
    _dataSourse = [NSMutableArray array];
    _userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
    
    if (!_userInfo) {
        _userInfo = [UserInfo new];
        //未登录时预设id为-88888
        _userInfo.userId = -88888;
    }
    NSString* comment_list_url_string = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/comment.api.php?act=list&page=0&count=100&newsid=%ld",self.newsId];
    [self getNewsDataWithUrl_string:comment_list_url_string];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *chatNib = [UINib nibWithNibName:@"HRChatCell" bundle:[NSBundle bundleForClass:[HRChatCell class]]];
    [self.tableView registerNib:chatNib forCellReuseIdentifier:RCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)send:(id)sender {
    
    //未登录时
    if (_userInfo.userId <= 0) {
        //提示登录或匿名评论
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您未登录，请登录或选择匿名评论" message:@"登录送智文" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *log_go = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            //push到登录界面
            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"logvc"] animated:YES];
        }];
        UIAlertAction *noName_go = [UIAlertAction actionWithTitle:@"匿名评论" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            _userInfo = [UserInfo new];
            _userInfo.userId = -80808080;
            //发送评论
            NSString *comment_add_param = [NSString stringWithFormat:@"<comments><comment>%@</comment><commenttime>%@</commenttime><userloc></userloc><userid>%ld</userid><newsid>%ld</newsid></comments>",self.textFiled.text,[NSDate date],_userInfo.userId,self.newsId];
            [self requestUrl:comment_add param:comment_add_param];
            self.textFiled.text = @"";
        }];
        
        [alertController addAction:log_go];
        [alertController addAction:noName_go];
        //以模态视图呈现
        [self presentViewController:alertController animated:YES completion:nil];

        
    }else//已登录
    {
    NSString *comment_add_param = [NSString stringWithFormat:@"<comments><comment>%@</comment><commenttime>%@</commenttime><userloc></userloc><userid>%ld</userid><newsid>%ld</newsid></comments>",self.textFiled.text,[NSDate date],_userInfo.userId,self.newsId];
    [self requestUrl:comment_add param:comment_add_param];
    self.textFiled.text = @"";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HRChatCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //提示框
    if (cell.item.userId != _userInfo.userId) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除这条记录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [_dataSourse removeObject:cell.item];
        [tableView reloadData];
        //删除评论
        NSString *comment_del_url_string = [NSString stringWithFormat:@"%@id=%ld",comment_del,cell.item.commentId];
        [self getNewsDataWithUrl_string:comment_del_url_string];
    }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
    }];
    
    [alertController addAction:ok];
    [alertController addAction:no];
    //以模态视图呈现
    [self presentViewController:alertController animated:YES completion:nil];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentItem *item = _dataSourse[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:RChatFontSize];
   // CGFloat height = [item.comment sizeWithFont:font constrainedToSize:CGSizeMake(150, 10000)].height;
    CGFloat height = [item.comment boundingRectWithSize:CGSizeMake(150, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.height;
                      
    CGFloat lineHeight = [font lineHeight];
    
    return RCellHeight + height - lineHeight +100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HRChatCell *cell = [tableView dequeueReusableCellWithIdentifier:RCellIdentifier];
    //倒叙
    [cell bindMessage:_dataSourse[_dataSourse.count - indexPath.row - 1]];

    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)getNewsDataWithUrl_string:(NSString*)url_string
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString* request_string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //移除<?xml version='1.0' encoding='UTF-8'?>
        NSRange removeRange = [request_string rangeOfString:@"<?xml version='1.0' encoding='UTF-8'?> "];
        request_string = [request_string substringFromIndex:removeRange.length];
        
        if (request_string.length == 0) {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                CommentItem *ci2 = [CommentItem new];
                ci2.comment = @"暂无数据";
                [_dataSourse addObject:ci2];
                //更新UI
                [_activity stopAnimating];
                [self.tableView reloadData];
            });
            return;
        }
        GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithXMLString:request_string options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
        
        //3.下面开始解析,解析应该在同一作用域中完成
        
        //3.1 从文档对象获取跟节点
        GDataXMLElement *rootElement = [xmlDocument rootElement];
        
        GDataXMLElement *dataElement = [rootElement elementsForName:@"data"].firstObject;
        //3.2 在rootElement 节点下获取所有root节点
        NSArray *arr_item_Element = [dataElement elementsForName:@"item"];
        
        
        //3.3 遍历
        for (GDataXMLElement *aElement in arr_item_Element) {
            
            GDataXMLElement *commentIdElement = [aElement elementsForName:@"id"].firstObject;
            NSInteger commentId = commentIdElement.stringValue.integerValue;
            
            GDataXMLElement *commentElement = [aElement elementsForName:@"comment"].firstObject;
            NSString* comment = commentElement.stringValue;
            
            GDataXMLElement *commenttimeElement = [aElement elementsForName:@"commenttime"].firstObject;
            NSString *commenttime = commenttimeElement.stringValue;
            
            GDataXMLElement *useridElement = [aElement elementsForName:@"userid"].firstObject;
            NSInteger userId = useridElement.stringValue.integerValue;
            
            GDataXMLElement *newsidElement = [aElement elementsForName:@"newsid"].firstObject;
            NSInteger newsId = newsidElement.stringValue.integerValue;
    
            CommentItem *ci = [CommentItem commentItemWithCommentId:commentId Comment:comment commenttime:commenttime userId:userId newsId:newsId];
            [_dataSourse addObject:ci];
           
            if (_dataSourse.count == 0) {
                CommentItem *ci2 = [CommentItem new];
                ci2.comment = @"暂无数据";
                [_dataSourse addObject:ci2];
            }
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                //更新UI
                [_activity stopAnimating];
                [self.tableView reloadData];
            });


        }
        
    }];
    [task resume];
    
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
    [_activity startAnimating];
    //发送请求
    
    //4.task
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //重新加载数据
        _dataSourse = [NSMutableArray array];
        NSString* comment_list_url_string = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/comment.api.php?act=list&page=0&count=100&newsid=%ld",self.newsId];
        [self getNewsDataWithUrl_string:comment_list_url_string];

        dispatch_async(mainQueue, ^{
            
            //更新UI
            [_activity stopAnimating];
            [self.tableView reloadData];
        });

    }];
    
    //5.执行
    [task resume];
}

-(void)getDataSourse
{
    //先清空datasourse
    [_dataSourse removeAllObjects];
    
    NSString* comment_list_url_string = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/comment.api.php?act=list&page=0&count=100&newsid=%ld",self.newsId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:comment_list_url_string]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString* request_string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //移除<?xml version='1.0' encoding='UTF-8'?>
        NSRange removeRange = [request_string rangeOfString:@"<?xml version='1.0' encoding='UTF-8'?> "];
        request_string = [request_string substringFromIndex:removeRange.length];
       
        if (request_string.length == 0) {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                CommentItem *ci2 = [CommentItem new];
                ci2.comment = @"暂无数据";
                [_dataSourse addObject:ci2];
                //更新UI
                [_activity stopAnimating];
                [self.tableView reloadData];
            });
            return;
        }
        GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithXMLString:request_string options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
        
        //3.下面开始解析,解析应该在同一作用域中完成
        
        //3.1 从文档对象获取跟节点
        GDataXMLElement *rootElement = [xmlDocument rootElement];
        
        GDataXMLElement *dataElement = [rootElement elementsForName:@"data"].firstObject;
        //3.2 在rootElement 节点下获取所有root节点
        NSArray *arr_item_Element = [dataElement elementsForName:@"item"];
        
        
        //3.3 遍历
        for (GDataXMLElement *aElement in arr_item_Element) {
            
            GDataXMLElement *commentIdElement = [aElement elementsForName:@"id"].firstObject;
            NSInteger commentId = commentIdElement.stringValue.integerValue;
            
            GDataXMLElement *commentElement = [aElement elementsForName:@"comment"].firstObject;
            NSString* comment = commentElement.stringValue;
            
            GDataXMLElement *commenttimeElement = [aElement elementsForName:@"commenttime"].firstObject;
            NSString *commenttime = commenttimeElement.stringValue;
            
            GDataXMLElement *useridElement = [aElement elementsForName:@"userid"].firstObject;
            NSInteger userId = useridElement.stringValue.integerValue;
            
            GDataXMLElement *newsidElement = [aElement elementsForName:@"newsid"].firstObject;
            NSInteger newsId = newsidElement.stringValue.integerValue;
            
            CommentItem *ci = [CommentItem commentItemWithCommentId:commentId Comment:comment commenttime:commenttime userId:userId newsId:newsId];
            [_dataSourse addObject:ci];
            
            if (_dataSourse.count == 0) {
                CommentItem *ci2 = [CommentItem new];
                ci2.comment = @"暂无数据";
                [_dataSourse addObject:ci2];
            }
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                //更新UI
                [_activity stopAnimating];
                [self.tableView reloadData];
            });
            
            
        }
        
    }];
    [task resume];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = self.view.frame;
    frame.size.height -= 260;
    self.view.frame = frame;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect frame = self.view.frame;
    frame.size.height += 260;
    self.view.frame = frame;
}

//分享
- (IBAction)shareButAction:(id)sender
{
   //文本分享
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"文本内容";
    req.bText = YES;
    req.scene = WXSceneSession;
    //图片分享
//    WXMediaMessage *message = [WXMediaMessage message];
//    [message setThumbImage:[UIImage imageNamed:@"load.png"]];
//    
//    WXImageObject *ext = [WXImageObject object];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"load" ofType:@"png"];
//    ext.imageData = [NSData dataWithContentsOfFile:filePath];
//    UIImage* image = [UIImage imageWithData:ext.imageData];
//    ext.imageData = UIImagePNGRepresentation(image);
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    req.scene = WXSceneTimeline;
    
    NSLog(@"%d", [WXApi sendReq:req]);

}


@end