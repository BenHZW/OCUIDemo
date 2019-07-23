
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
#define comment_add @"http://knews.sinaapp.com/api-2/comment.api.php?act=add"
#define comment_del @"http://knews.sinaapp.com/api-2/comment.api.php?act=del&"
@interface CommitViewController ()<UITextFieldDelegate>
{
    //数据源
    NSMutableArray *_dataSourse;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation CommitViewController
static NSString * const RCellIdentifier = @"HRChatCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSourse = [NSMutableArray array];
    
    //实例refresh类
    qshRefreshView = [[QSHRefresh alloc] initWithFrame:CGRectMake(0, -self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    //刷新的图片样式 (枚举，暂时就两个，一个是箭头，一个是表盘,默认是箭头)
    [qshRefreshView setImageType:QSHRefreshImageArrow];
    //    [qshRefreshView setImageType:QSHRefreshImageWatch];
    qshRefreshView.delegate = self;
    [self.tableView addSubview:qshRefreshView];
    [qshRefreshView refreshLastUpdatedDate];
    
    
    
    NSString* comment_list_url_string = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/comment.api.php?act=list&page=0&count=100&newsid=%ld",self.newsId];
    [self getNewsDataWithUrl_string:comment_list_url_string];
    
    self.title = @"屌丝们的泡妞攻略";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *chatNib = [UINib nibWithNibName:@"HRChatCell" bundle:[NSBundle bundleForClass:[HRChatCell class]]];
    [self.tableView registerNib:chatNib forCellReuseIdentifier:RCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)send:(id)sender {
    
    NSString *comment_add_param = [NSString stringWithFormat:@"<comments><comment>%@</comment><commenttime>%@</commenttime><userloc></userloc><userid>66</userid><newsid>%ld</newsid></comments>",self.textFiled.text,[NSDate date],self.newsId];
    [self requestUrl:comment_add param:comment_add_param];
    self.textFiled.text = @"";

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HRChatCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //提示框
    if (cell.item.userId != 66) {
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
    
    return RCellHeight + height - lineHeight +25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HRChatCell *cell = [tableView dequeueReusableCellWithIdentifier:RCellIdentifier];
    [cell bindMessage:_dataSourse[indexPath.row]];

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
        NSLog(@"request_string:%@",request_string);
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
            NSLog(@"_______%@",_dataSourse);
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
        NSLog(@"datastr:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response:%@",response);
        NSLog(@"error:%@",error);
        
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
        NSLog(@"request_string:%@",request_string);
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
            NSLog(@"_______%@",_dataSourse);
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
#pragma mark - ------------以下为refresh类中的方法，照抄就行--------

#pragma mark - -------------刷新数据---------------

//设置成要加载
- (void)reloadTableViewDataSource{
    [self getDataSourse];
    _reloading = YES;
    //处理加载完成后的事件
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
    
}

//加载结束，设置成不要加载
- (void)doneLoadingTableViewData{
    
    _reloading = NO;
    
    [qshRefreshView qshRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}



#pragma mark - -----------scrollView代理方法-------------
//触发scrollView代理方法时对应进入刷新类中的方法
//表格正在拖动，调用刷新类的拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [qshRefreshView qshRefreshScrollViewDidScroll:scrollView];
    
    
}
//结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [qshRefreshView qshRefreshScrollViewDidEndDragging:scrollView];
    
}

#pragma mark - ------------刷新类代理方法----------------

- (void)qshRefreshDidTriggerRefresh:(QSHRefresh *)view{
    //设置要加载
    [self reloadTableViewDataSource];
    
}

- (BOOL)qshRefreshDataSourceIsLoading:(QSHRefresh *)view{
    
    return _reloading;
    
}

- (NSDate *)qshRefreshDataSourceLastUpdated:(QSHRefresh *)view{
    
    return [NSDate date];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}
@end
