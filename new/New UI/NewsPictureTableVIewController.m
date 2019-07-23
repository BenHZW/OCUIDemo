//
//  TableViewControllerB.m
//  New UI
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//


#import "GDataXMLNode.h"
#import "AItem.h"
#import "DetailViewController.h"

#define name 1111111
#define passwork "kallen"
#define login_web @"http://knews.sinaapp.com/api-2/login.api-2.php?act=login"
#define register_web @"http://knews.sinaapp.com/api-2/register.api.php?act=register"
#define modify @"http://knews.sinaapp.com/api-2/register.api.php?act=modify"
#define comment_add @"http://knews.sinaapp.com/api-2/comment.api.php?act=add"
#define comment_del @"http://knews.sinaapp.com/api-2/comment.api.php?act=del&"


#import "NewsPictureTableVIewController.h"
#import "ImageTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "ImageViewController.h"
#import "DetailViewController.h"


@interface NewsPictureTableVIewController ()

{
    
    NSMutableArray *_dataSource;
 
  
   
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@end

@implementation NewsPictureTableVIewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if( self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable )
    {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    
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

    
    //初始化数据路径
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    //文件名
    NSString *downloadingPath = [document stringByAppendingPathComponent:@"imageList"];
    
    //读取数据片段文件
    NSData *downloadingData = [[NSData alloc] initWithContentsOfFile:downloadingPath];
    
    //创建会话对象
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionDownloadTask *downloadingTask;
    
    //根据片段建立请求
    //从会话对象创建任务对象
    if (downloadingData == nil)
    {
        
        NSURL *imageUrl = [NSURL URLWithString:@"http://knews.sinaapp.com/api-2/news.api.php?act=imgNewsList&page=0&count=5&cid=3"];
        
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageUrl];
        
        downloadingTask = [downloadSession downloadTaskWithRequest:imageRequest];
    }
    
    else
    {
        downloadingTask = [downloadSession downloadTaskWithResumeData:downloadingData];
    }
    
    [downloadingTask resume];
    

}
//下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *idata = [NSData dataWithContentsOfURL:location];
    
    //删除片段
    NSFileManager *fileMagager = [NSFileManager defaultManager];
    
    [fileMagager removeItemAtURL:location error:nil];
    
    NSData *recieveData = [[NSData alloc] initWithData:idata];
    
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:recieveData options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
    
    //3.下面开始解析,解析应该在同一作用域中完成
    
    //3.1 从文档对象获取跟节点
    GDataXMLElement *rootElement = [xmlDocument rootElement];
    
    GDataXMLElement *dataElement = [rootElement elementsForName:@"data"].firstObject;
    //3.2 在rootElement 节点下获取所有root节点
    NSArray *arr_item_Element = [dataElement elementsForName:@"item"];
    
    
    //保存新闻的数组
    NSMutableArray *items = [[NSMutableArray alloc]initWithCapacity:arr_item_Element.count];
    //3.3 遍历
    for (GDataXMLElement *aElement in arr_item_Element) {
        GDataXMLElement *idElement = [aElement elementsForName:@"id"].firstObject;
        NSInteger newsId = idElement.stringValue.integerValue;

        
        GDataXMLElement *titleElement = [aElement elementsForName:@"title"].firstObject;
        NSString *title = titleElement.stringValue;

        
        GDataXMLElement *contentElement = [aElement elementsForName:@"content"].firstObject;
        NSString *content = contentElement.stringValue;
        //解析HTML
        NSMutableString *content1 = [NSMutableString stringWithString:contentElement.stringValue];
        NSRange rang1 = [content1 rangeOfString:@"<"];
        while (rang1.location != NSNotFound) {
            NSRange rang2 = [content1 rangeOfString:@">"];
            [content1 replaceCharactersInRange:NSMakeRange(rang1.location, rang2.location-rang1.location+1) withString:@" "];
            rang1 = [content1 rangeOfString:@"<"];
            
        }
        content = content1;

        
        GDataXMLElement *categoryidElement = [aElement elementsForName:@"categoryid"].firstObject;
        NSInteger categoryid = categoryidElement.stringValue.integerValue;
        
        GDataXMLElement *authoridElement = [aElement elementsForName:@"authorid"].firstObject;
        NSInteger authorid = authoridElement.stringValue.integerValue;
        
        GDataXMLElement *publishtimeElement = [aElement elementsForName:@"publishtime"].firstObject;
        NSString *publishtime = publishtimeElement.stringValue;
        
        GDataXMLElement *imagesElement = [aElement elementsForName:@"pics"].firstObject;
        NSArray *arr_imagesItem_Element = [imagesElement elementsForName:@"item"];
        //保存图片的数组
        NSMutableArray *images = [[NSMutableArray alloc]initWithCapacity:arr_imagesItem_Element.count];
        for (GDataXMLElement *imageStrElement in arr_imagesItem_Element) {
            NSString *aimageUrlStr = imageStrElement.stringValue;
            [images addObject:aimageUrlStr];
        }
        
        GDataXMLElement *infoElement = [aElement elementsForName:@"info"].firstObject;
        NSArray *arr_infoItem_Element = [infoElement elementsForName:@"item"];
        //保存info的数组
        NSMutableArray *infos = [[NSMutableArray alloc]initWithCapacity:arr_infoItem_Element.count];
        for (GDataXMLElement *infoStrElement in arr_infoItem_Element) {
            NSString *aInfo = infoStrElement.stringValue;
            [infos addObject:aInfo];
        }
        
        
        AItem *item = [AItem aItemWithNewsid:newsId title:title content:content categoryid:categoryid authorid:authorid publishtime:publishtime];
        item.images = images;
        item.infos = infos;
        [items addObject:item];
        
    }
    
    _dataSource = [NSMutableArray arrayWithArray:items];
    
    NSLog(@"abc:%ld",_dataSource.count);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityView stopAnimating];
        [self.tableView reloadData];
        
    });
    


    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Peek and Pop
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}


- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    
    ImageTableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    
    if (selectedCell == nil)
    {
        return nil;
    }
    
    [previewingContext setSourceRect:selectedCell.frame];
    
    DetailViewController *detailViewControllerToShow = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
#pragma mark - 传值
    detailViewControllerToShow.transformImage = selectedCell.myImage.image;
    
    
   detailViewControllerToShow.preferredContentSize = CGSizeMake(0, 400);
    
    return detailViewControllerToShow;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return _dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    AItem *item = [AItem new];
    
    item = _dataSource[indexPath.row];
    
    cell.myTitle.text = item.title;
    
    UIImage *loading = [UIImage imageNamed:@"loading.png"];
    
    NSURL *url = [NSURL URLWithString:item.images.firstObject];
    
    
    [cell.myImage sd_setImageWithURL:url placeholderImage:loading];
       
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//    ImageViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ImageVC"];
//
//    AItem *item = [AItem new];
//
//    item = _dataSource[indexPath.row];
//
//    vc.imageArray = item.images;
//    
//    vc.infoArray = item.infos;
//    
//    vc.myTitle = item.title;
//    
//    vc.view.backgroundColor = [UIColor blackColor];
//
//  // [self.navigationController pushViewController:vc animated:YES];
//}

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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ImageViewController *vc = segue.destinationViewController;
    
    
        AItem *item = [AItem new];
    
        item = _dataSource[[self.tableView indexPathForCell:sender] .row];
    
        vc.imageArray = item.images;
    
        vc.infoArray = item.infos;
    
        vc.myTitle = item.title;
    
        vc.view.backgroundColor = [UIColor blackColor];

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
