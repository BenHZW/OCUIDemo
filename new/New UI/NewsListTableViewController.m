//
//  TableViewControllerA.m
//  New UI
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NewsListTableViewController.h"
#import "MyTableViewCell.h"
#import "GDataXMLNode.h"
#import "AItem.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Detail_ListViewController.h"
@interface NewsListTableViewController ()
{
    //数据源
    NSMutableArray *_items ;
    
    //下载对象
    NSURLSessionDownloadTask *_downloadTask;
    NSURLSession *downloadSession;
    
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@end

@implementation NewsListTableViewController
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"122112");
    
  NSData *data_xml = [[NSData alloc]initWithContentsOfURL:location];

    
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:data_xml options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
    
    //3.下面开始解析,解析应该在同一作用域中完成
    
    //3.1 从文档对象获取跟节点
    GDataXMLElement *rootElement = [xmlDocument rootElement];
    
    GDataXMLElement *dataElement = [rootElement elementsForName:@"data"].firstObject;
    //3.2 在rootElement 节点下获取所有root节点
    NSArray *arr_item_Element = [dataElement elementsForName:@"item"];
    
    
    //保存新闻的数组
    
    _items = [NSMutableArray new];
    //3.3 遍历
    for (GDataXMLElement *aElement in arr_item_Element) {
        GDataXMLElement *idElement = [aElement elementsForName:@"id"].firstObject;
        NSInteger newsId = idElement.stringValue.integerValue;
        
        GDataXMLElement *titleElement = [aElement elementsForName:@"title"].firstObject;
        NSString *title = titleElement.stringValue;
        
        GDataXMLElement *imagesElement = [aElement elementsForName:@"images"].firstObject;
        NSArray *arr_imagesItem_Element = [imagesElement elementsForName:@"item"];
        //保存图片的数组
        NSMutableArray *images = [[NSMutableArray alloc]initWithCapacity:arr_imagesItem_Element.count];
        for (GDataXMLElement *imageStrElement in arr_imagesItem_Element) {
            NSString *aimageUrlStr = imageStrElement.stringValue;
            [images addObject:aimageUrlStr];
        }
        //        NSLog(@"images:%@",images);
        
        GDataXMLElement *contentElement = [aElement elementsForName:@"content"].firstObject;
        NSString *content = contentElement.stringValue;
        
        
        //解析HTML
        NSMutableString *content1 = [NSMutableString stringWithString:contentElement.stringValue];
        NSRange rang1 = [content1 rangeOfString:@"<"];
        while (rang1.location != NSNotFound) {
            NSRange rang2 = [content1 rangeOfString:@">"];
            [content1 replaceCharactersInRange:NSMakeRange(rang1.location, rang2.location-rang1.location+1) withString:@"///"];
            rang1 = [content1 rangeOfString:@"<"];
            
        }
        
        content = content1;
        
        GDataXMLElement *categoryidElement = [aElement elementsForName:@"categoryid"].firstObject;
        NSInteger categoryid = categoryidElement.stringValue.integerValue;
        //        NSLog(@"categoryid;%ld",categoryid);
        
        GDataXMLElement *authoridElement = [aElement elementsForName:@"authorid"].firstObject;
        NSInteger authorid = authoridElement.stringValue.integerValue;
        //        NSLog(@"authorid;%ld",authorid);
        
        GDataXMLElement *publishtimeElement = [aElement elementsForName:@"publishtime"].firstObject;
        NSString *publishtime = publishtimeElement.stringValue;
        //        NSLog(@"publishtime;%@",publishtime);
        
        AItem *item = [AItem aItemWithNewsid:newsId title:title content:content categoryid:categoryid authorid:authorid publishtime:publishtime];
        item.images = images;
        [_items addObject:item];
    }

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityView stopAnimating];
        [self.tableView reloadData];
    });
    
}



-(void)awakeFromNib
{
    self.value = 1;
   

}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建配置对象
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //使用配置对象，创建会话对象
    downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    //实例refresh类
    qshRefreshView = [[QSHRefresh alloc] initWithFrame:CGRectMake(0, -self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    //刷新的图片样式 (枚举，暂时就两个，一个是箭头，一个是表盘,默认是箭头)
    [qshRefreshView setImageType:QSHRefreshImageArrow];
    //    [qshRefreshView setImageType:QSHRefreshImageWatch];
    qshRefreshView.delegate = self;
    [self.tableView addSubview:qshRefreshView];
    [qshRefreshView refreshLastUpdatedDate];
    
    [self getDataSource];
    
    
}
-(void)getDataSource
{
    //创建URL对象
    NSURL *url = [NSURL URLWithString:@"http://knews.sinaapp.com/api-2/news.api.php?act=list&page=0&count=20"];
    
    //创建请求对象
    NSURLRequest *Request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    //由会话对象根据请求对象创建下载任务
    _downloadTask = [downloadSession downloadTaskWithRequest:Request];
    
    
    //开始
    [_downloadTask resume];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return _array1.count;
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idf" forIndexPath:indexPath];
    
    AItem *aitem = [AItem new];
    
    aitem = _items[indexPath.row];
    
    
    cell.MyLabel.text = aitem.title;
    
    NSURL *url = [NSURL URLWithString:aitem.images.firstObject];
    
    [cell.MyImageView sd_setImageWithURL:url];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MyTableViewCell *cell = sender;
    
   AItem *aitem  =   _items[[self.tableView indexPathForCell:cell].row ];
   
    Detail_ListViewController * aVC = segue.destinationViewController;
    NSString *content = aitem.content;
    NSArray *strArray = [content componentsSeparatedByString:@"///"];
    
    NSString *str = [NSString new];
    
    for (NSInteger i = 0; i < strArray.count; ++i)
    {
        if (i > 0)
        {
          str = [str stringByAppendingFormat:@"\n    %@", strArray[i]];
        }
    }
    
    
   // aVC.str = aitem.content;
    aVC.str = str;
    aVC.pic = aitem.images.firstObject;
    
    

}
#pragma mark - ------------以下为refresh类中的方法，照抄就行--------

#pragma mark - -------------刷新数据---------------

//设置成要加载
- (void)reloadTableViewDataSource{
    [self getDataSource];
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

@end
