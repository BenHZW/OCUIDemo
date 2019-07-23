//
//  TableViewControllerC.m
//  New UI
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NewsVideoTableViewController.h"
#import "GDataXMLNode.h"
#import "AItem.h"
#import "VideoTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "CommitViewController.h"
@interface NewsVideoTableViewController ()
{
    NSMutableArray *_items;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation NewsVideoTableViewController


-(void)awakeFromNib
{
    self.value = 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实例refresh类
    qshRefreshView = [[QSHRefresh alloc] initWithFrame:CGRectMake(0, -self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    //刷新的图片样式 (枚举，暂时就两个，一个是箭头，一个是表盘,默认是箭头)
    [qshRefreshView setImageType:QSHRefreshImageArrow];
    //    [qshRefreshView setImageType:QSHRefreshImageWatch];
    qshRefreshView.delegate = self;
    [self.tableView addSubview:qshRefreshView];
    [qshRefreshView refreshLastUpdatedDate];
    
    
    self.title = @"视频新闻";
    [self getDataSourse];
}

//加载数据源方法
-(void)getDataSourse
{
    dispatch_queue_t takeMoneyQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(takeMoneyQueue, ^{
        
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        
        NSData *data_xml = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://knews.sinaapp.com/api-2/news.api.php?act=videoList&page=0&count=10&cid=4"] options:0 error:nil];
        
        GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:data_xml options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
        
        //3.下面开始解析,解析应该在同一作用域中完成
        
        //3.1 从文档对象获取跟节点
        GDataXMLElement *rootElement = [xmlDocument rootElement];
        
        GDataXMLElement *dataElement = [rootElement elementsForName:@"data"].firstObject;
        //3.2 在rootElement 节点下获取所有root节点
        NSArray *arr_item_Element = [dataElement elementsForName:@"item"];
        NSMutableArray *images = [NSMutableArray array];
        
        //保存新闻的数组
        _items = [NSMutableArray array];
        //3.3 遍历
        for (GDataXMLElement *aElement in arr_item_Element) {
            images = [NSMutableArray array];
            GDataXMLElement *idElement = [aElement elementsForName:@"id"].firstObject;
            NSInteger newsId = idElement.stringValue.integerValue;
            //NSLog(@"newsid;%ld",newsId);
            
            GDataXMLElement *titleElement = [aElement elementsForName:@"title"].firstObject;
            NSString *title = titleElement.stringValue;
            //NSLog(@"title;%@",title);
            
            GDataXMLElement *contentElement = [aElement elementsForName:@"content"].firstObject;
            NSString *content = contentElement.stringValue;
            
            //先获取视频中的一张图片
            NSRange rang_httpH = [content rangeOfString:@"http://knews-upload.stor.sinaapp.com/ueditor/php/upload/image/"];
            if(rang_httpH.location != NSNotFound)
            {
                NSRange rang_httpF = [content rangeOfString:@".png"];
                if (rang_httpF.location == NSNotFound) {
                    rang_httpF = [content rangeOfString:@".jpg"];
                }
                NSString *imageStr = [content substringWithRange:NSMakeRange(rang_httpH.location, rang_httpF.location+4 - rang_httpH.location)];
                NSLog(@"imageStr:%@",imageStr);
                [images addObject:imageStr];
            }else
            {
                [images addObject:[NSString stringWithFormat:@"http://up.ekoooo.com/uploads2/tubiao/4/2008861555448477809.png"]];
            }
            //解析HTML
            NSMutableString *content1 = [NSMutableString stringWithString:contentElement.stringValue];
            
            NSRange rang1 = [content1 rangeOfString:@"<"];
            while (rang1.location != NSNotFound) {
                NSRange rang2 = [content1 rangeOfString:@">"];
                [content1 replaceCharactersInRange:NSMakeRange(rang1.location, rang2.location-rang1.location+1) withString:@""];
                rang1 = [content1 rangeOfString:@"<"];
                
            }
            
            content = content1;
            
            NSLog(@"content;%@",content);
            
            GDataXMLElement *categoryidElement = [aElement elementsForName:@"categoryid"].firstObject;
            NSInteger categoryid = categoryidElement.stringValue.integerValue;
            //NSLog(@"categoryid;%ld",categoryid);
            
            GDataXMLElement *authoridElement = [aElement elementsForName:@"authorid"].firstObject;
            NSInteger authorid = authoridElement.stringValue.integerValue;
            //NSLog(@"authorid;%ld",authorid);
            
            GDataXMLElement *publishtimeElement = [aElement elementsForName:@"publishtime"].firstObject;
            NSString *publishtime = publishtimeElement.stringValue;
            //NSLog(@"publishtime;%@",publishtime);
            
            GDataXMLElement *videourlElement = [aElement elementsForName:@"videourl"].firstObject;
            NSString *videourl = videourlElement.stringValue;
            //NSLog(@"videourl:%@",videourl);
            
            
            AItem *item = [AItem aItemWithNewsid:newsId title:title content:content categoryid:categoryid authorid:authorid publishtime:publishtime];
            item.videourl = videourl;
            item.images = images;
            if (item.videourl.length > 0) {
                NSLog(@"%@",item.videourl);
                [_items addObject:item];
            }
            
            
        }
        
        
        dispatch_async(mainQueue, ^{
            
            //更新UI
            [_activityView stopAnimating];
            [self.tableView reloadData];
        });
        
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AItem *item = _items[indexPath.row];
    cell.titleLabel.text = item.title;
    cell.videoImageUrl = item.images.firstObject;
    cell.numberComment.text = @"6";
    NSString *urlStr = item.images.firstObject;

    NSURL *url = [NSURL URLWithString:urlStr];
    [cell.aImageVIew sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"load.png"] ];
    cell.item = item;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     CommitViewController *vcvc = segue.destinationViewController;
     VideoTableViewCell *cell = sender;
     vcvc.newsId = cell.item.newsId;
     
     
     
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

@end
