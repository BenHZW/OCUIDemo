//
//  ViewController.m
//  NewNew
//
//  Created by 3024 on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import "ViewController.h"
#import "ListCell.h"
#import "ImageCell.h"
#import "VideoCell.h"
#import "DataSouceDelegate.h"
#import "AItem.h"
#import "GDataXMLNode.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "NavViewController.h"
#import "CommitViewController.h"
#import "ImageViewController.h"
#import "Detail_ListViewController.h"

#define NOTIFICATION @"NOTIFICATION"
@interface ViewController ()<UIScrollViewDelegate,MoviePlayDelegate>
{
    UITableView *tableView1;
    UITableView *tableView2;
    UITableView *tableView3;
    UIPageControl *_pageControl;
    
    //数据源
    NSMutableDictionary *_dataSource;
    //视频
    CustomMoviePlayerView *movieView;
    NSString *urlStr;
    NSIndexPath *indexPaths;
    
    //加载更多数据
    NSInteger _i,_j,_k;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始数据页数
    _i = _j = _k = 0;
    
    _dataSource = [NSMutableDictionary dictionary];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"back.png"] forBarMetrics:UIBarMetricsDefault];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect rect = [UIScreen mainScreen].bounds;
    //64为导航栏所占的高度
    rect.size.height -= self.ListBut.frame.size.height + 64;
    rect.origin.y += self.ListBut.frame.size.height;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:rect];
    self.scrollView.backgroundColor = [UIColor clearColor];
    CGSize size = self.scrollView.frame.size;
    size.width *= 3;
    self.scrollView.contentSize = size;
    [self.view addSubview:self.scrollView];
    CGFloat height =self.scrollView.frame.size.height;
    CGFloat width =self.scrollView.frame.size.width;
    
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(width, 0, width,height)];
    tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(width*2, 0,width,height)];
    [self.scrollView addSubview:tableView1];
    [self.scrollView addSubview:tableView2];
    [self.scrollView addSubview:tableView3];
    _pageControl = [UIPageControl appearance];
    _scrollView.pagingEnabled = YES;
    _pageControl.numberOfPages = 3;
    _pageControl.defersCurrentPageDisplay = YES;
    _scrollView.delegate = self;
    
    //按钮默认第一个选中
    self.ListBut.selected = YES;
    [self.ListBut setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.imgBut setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.videoBut setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    //接收当前页改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageChange:) name:NOTIFICATION object:nil];
    
    tableView1.delegate = self;
    tableView2.delegate = self;
    tableView3.delegate = self;
    tableView1.dataSource = self;
    tableView2.dataSource = self;
    tableView3.dataSource = self;
    
    //3.给表视图注册要显示单元格的类型以及对应的标识符
    //1
    [tableView1 registerClass:[ListCell class] forCellReuseIdentifier:@"ListCell"];
    DataSouceDelegate *dataSourceDelegate = [DataSouceDelegate new];
    
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(aQueue, ^{
        NSData *aData = [dataSourceDelegate getData:@"http://knews.sinaapp.com/api-2/news.api.php?act=list&page=0&count=20"];
        //解析数据
        NSArray *ListDataSource = [self analysisData_List:aData];
        [_dataSource setObject:ListDataSource forKey:@"ListDataSource"];
        //解析完刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView1 reloadData];
        });
    });
    //2
    [tableView2 registerClass:[ImageCell class] forCellReuseIdentifier:@"ImageCell"];
    dispatch_queue_t bQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(bQueue, ^{
        NSData *aData = [dataSourceDelegate getData:@"http://knews.sinaapp.com/api-2/news.api.php?act=imgNewsList&page=0&count=5&cid=3"];
        //解析数据
        NSArray *imageNewsDataSource = [self analysisData_ImageNews:aData];
        [_dataSource setObject:imageNewsDataSource forKey:@"ImageNewsDataSource"];
        //解析完刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView2 reloadData];
        });
    });
    //3
    [tableView3 registerClass:[VideoCell class] forCellReuseIdentifier:@"VideoCell"];
    dispatch_queue_t cQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(cQueue, ^{
        NSData *aData = [dataSourceDelegate getData:@"http://knews.sinaapp.com/api-2/news.api.php?act=videoList&page=0&count=10&cid=4"];
        //解析数据
        NSArray *VideoDataSource = [self analysisData_Video:aData];
        [_dataSource setObject:VideoDataSource forKey:@"VideoNewsDataSource"];
        //解析完刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView3 reloadData];
        });
    });
    
    //头像
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 40, 40);
    menuBtn.layer.cornerRadius = 20.0;
    menuBtn.layer.masksToBounds = 20.0;
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"man.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    //下拉刷新界面
    //实例refresh类1
    qshRefreshView1 = [[QSHRefresh alloc] initWithFrame:CGRectMake(0, -tableView1.bounds.size.height, self.view.frame.size.width, tableView1.bounds.size.height)];
    //刷新的图片样式 (枚举，暂时就两个，一个是箭头，一个是表盘,默认是箭头)
    [qshRefreshView1 setImageType:QSHRefreshImageArrow];
    //    [qshRefreshView setImageType:QSHRefreshImageWatch];
    
    qshRefreshView2 = [[QSHRefresh alloc] initWithFrame:CGRectMake(0, -tableView2.bounds.size.height, self.view.frame.size.width, tableView2.bounds.size.height)];
    //刷新的图片样式 (枚举，暂时就两个，一个是箭头，一个是表盘,默认是箭头)
    //[qshRefreshView2 setImageType:QSHRefreshImageArrow];
    [qshRefreshView2 setImageType:QSHRefreshImageWatch];
    
    qshRefreshView3 = [[QSHRefresh alloc] initWithFrame:CGRectMake(0, -tableView3.bounds.size.height, self.view.frame.size.width, tableView3.bounds.size.height)];
    //刷新的图片样式 (枚举，暂时就两个，一个是箭头，一个是表盘,默认是箭头)
    [qshRefreshView3 setImageType:QSHRefreshImageArrow];
    //    [qshRefreshView setImageType:QSHRefreshImageWatch];
    
    qshRefreshView1.delegate = self;
    qshRefreshView2.delegate = self;
    qshRefreshView3.delegate = self;
    [tableView1 addSubview:qshRefreshView1];
    [tableView2 addSubview:qshRefreshView2];
    [tableView3 addSubview:qshRefreshView3];
    [qshRefreshView1 refreshLastUpdatedDate];
    [qshRefreshView2 refreshLastUpdatedDate];
    [qshRefreshView3 refreshLastUpdatedDate];

    
}
//关闭、打开抽屉
- (void) openOrCloseLeftList
{
    NavViewController *navc = (NavViewController*)self.navigationController;
    if(navc.lsvc.closed)
    {
        [navc.lsvc openLeftView];
    }
    else
    {
        [navc.lsvc closeLeftView];
    }
    
}
//通知回调方法
-(void)pageChange:(NSNotification*)n
{
    NSNumber *page = n.object;
    NSInteger pageInt = page.integerValue;
    switch (pageInt) {
        case 0:
            self.ListBut.selected = YES;
            self.imgBut.selected = NO;
            self.videoBut.selected = NO;
            [tableView1 reloadData];
            break;
        case 1:
            self.ListBut.selected = NO;
            self.imgBut.selected = YES;
            self.videoBut.selected = NO;
            [tableView2 reloadData];
            break;
        case 2:
            self.ListBut.selected = NO;
            self.imgBut.selected = NO;
            self.videoBut.selected = YES;
            [tableView3 reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - ScrollView代理方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //横向拖动才执行
    if(velocity.x != 0){
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        
        float width = CGRectGetWidth(screenFrame);
        
        _pageControl.currentPage = (NSInteger)(targetContentOffset->x) / width;
        
        NSNumber *page = [NSNumber numberWithInteger:_pageControl.currentPage];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION object:page];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonPressed:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            self.ListBut.selected = YES;
            self.imgBut.selected = NO;
            self.videoBut.selected = NO;
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            _pageControl.currentPage = 0;
            [tableView1 reloadData];
            break;
        case 1:
            self.ListBut.selected = NO;
            self.imgBut.selected = YES;
            self.videoBut.selected = NO;
            [_scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
            _pageControl.currentPage = 1;
            [tableView2 reloadData];
            break;
        case 2:
            self.ListBut.selected = NO;
            self.imgBut.selected = NO;
            self.videoBut.selected = YES;
            [_scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*2, 0) animated:YES];
            _pageControl.currentPage = 2;
            [tableView3 reloadData];
            break;
        default:
            break;
    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 数据解析
-(NSArray*)analysisData_Video:(NSData*)data
{
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:data options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
    
    //3.下面开始解析,解析应该在同一作用域中完成
    
    //3.1 从文档对象获取跟节点
    GDataXMLElement *rootElement = [xmlDocument rootElement];
    
    GDataXMLElement *dataElement = [rootElement elementsForName:@"data"].firstObject;
    //3.2 在rootElement 节点下获取所有root节点
    NSArray *arr_item_Element = [dataElement elementsForName:@"item"];
    NSMutableArray *images = [NSMutableArray array];
    
    //保存新闻的数组
    NSMutableArray* items = [NSMutableArray array];
    //3.3 遍历
    for (GDataXMLElement *aElement in arr_item_Element) {
        images = [NSMutableArray array];
        GDataXMLElement *idElement = [aElement elementsForName:@"id"].firstObject;
        NSInteger newsId = idElement.stringValue.integerValue;
        
        GDataXMLElement *titleElement = [aElement elementsForName:@"title"].firstObject;
        NSString *title = titleElement.stringValue;
        
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
        
        GDataXMLElement *categoryidElement = [aElement elementsForName:@"categoryid"].firstObject;
        NSInteger categoryid = categoryidElement.stringValue.integerValue;
        
        GDataXMLElement *authoridElement = [aElement elementsForName:@"authorid"].firstObject;
        NSInteger authorid = authoridElement.stringValue.integerValue;
        
        GDataXMLElement *publishtimeElement = [aElement elementsForName:@"publishtime"].firstObject;
        NSString *publishtime = publishtimeElement.stringValue;
        
        GDataXMLElement *videourlElement = [aElement elementsForName:@"videourl"].firstObject;
        NSString *videourl = videourlElement.stringValue;
        
        
        AItem *item = [AItem aItemWithNewsid:newsId title:title content:content categoryid:categoryid authorid:authorid publishtime:publishtime];
        item.videourl = videourl;
        item.images = images;
        if (item.videourl.length > 0) {
            [items addObject:item];
        }
        
    }
    return items;
    
}
-(NSArray*)analysisData_List:(NSData*)data
{
    NSMutableArray *items = [NSMutableArray array];
    
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:data options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
    
    //3.下面开始解析,解析应该在同一作用域中完成
    
    //3.1 从文档对象获取跟节点
    GDataXMLElement *rootElement = [xmlDocument rootElement];
    
    GDataXMLElement *dataElement = [rootElement elementsForName:@"data"].firstObject;
    //3.2 在rootElement 节点下获取所有root节点
    NSArray *arr_item_Element = [dataElement elementsForName:@"item"];
    
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
        
        GDataXMLElement *contentElement = [aElement elementsForName:@"content"].firstObject;
        NSString *content = contentElement.stringValue;
        
        //解析HTML
        NSString *pattern = @"<([^<>]*)>";
        
        NSMutableString *content1 = [NSMutableString stringWithString:content];
        
        [content1 replaceOccurrencesOfString:pattern withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, content.length)];
        
        content = content1;
        
        GDataXMLElement *categoryidElement = [aElement elementsForName:@"categoryid"].firstObject;
        NSInteger categoryid = categoryidElement.stringValue.integerValue;
        
        GDataXMLElement *authoridElement = [aElement elementsForName:@"authorid"].firstObject;
        NSInteger authorid = authoridElement.stringValue.integerValue;
        
        GDataXMLElement *publishtimeElement = [aElement elementsForName:@"publishtime"].firstObject;
        NSString *publishtime = publishtimeElement.stringValue;
        
        AItem *item = [AItem aItemWithNewsid:newsId title:title content:content categoryid:categoryid authorid:authorid publishtime:publishtime];
        item.images = images;
        [items addObject:item];
    }
    return items;
    
}
-(NSArray*)analysisData_ImageNews:(NSData*)data
{
    
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc]initWithData:data options:XML_PARSE_NOBASEFIX|XML_PARSE_NOBLANKS error:nil];
    
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
    return items;
}
#pragma mark -表视图代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (_pageControl.currentPage) {
        case 0:
        {
            UINib *nib=[UINib nibWithNibName:@"ListCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"ListCell"];
            ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
            NSArray *datas = _dataSource[@"ListDataSource"];
            AItem *item = datas[indexPath.row];
            cell.title.text = item.title;
            NSMutableString *time = [NSMutableString stringWithString:item.publishtime];
            cell.time.text = [time substringToIndex:10];
            [cell.aImageView sd_setImageWithURL:[NSURL URLWithString:item.images.firstObject]];
            
            return cell;
        }
            break;
        case 1:
        {
            UINib *nib=[UINib nibWithNibName:@"ImageCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"ImageCell"];
            ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
            NSArray *datas = _dataSource[@"ImageNewsDataSource"];
            AItem *item = datas[indexPath.row];
            cell.title.text = item.title;
            NSMutableString *time = [NSMutableString stringWithString:item.publishtime];
            cell.time.text = [time substringToIndex:10];
            [cell.aImageView sd_setImageWithURL:[NSURL URLWithString:item.images.firstObject]];
            
            return cell;
        }
            break;
        default:
        {
            UINib *nib=[UINib nibWithNibName:@"VideoCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"VideoCell"];
            VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
            NSArray *datas = _dataSource[@"VideoNewsDataSource"];
            AItem *item = datas[indexPath.row];
            [cell.titleBut setTitle:item.title forState:UIControlStateNormal];
            cell.titleBut.tag = item.newsId;
            cell.backImage = item.images.firstObject;
            cell.urlStr = item.videourl;
            cell.delegate = self;
            cell.indexPath = indexPath;
            [cell.titleBut addTarget:self action:@selector(videoButPressed:)  forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
    }
    
}
//视频标题按钮响应方法
-(void)videoButPressed:(UIButton*)button
{
    CommitViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"cvc"];
    cvc.newsId = button.tag;
    [self.navigationController pushViewController:cvc animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_pageControl.currentPage) {
        case 0:
        {
            NSArray *datas = _dataSource[@"ListDataSource"];
            return datas.count;
        }
            break;
        case 1:
        {
            NSArray *datas = _dataSource[@"ImageNewsDataSource"];
            return datas.count;
        }
            break;
        default:
        {
            NSArray *datas = _dataSource[@"VideoNewsDataSource"];
            return datas.count;
        }
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_pageControl.currentPage) {
        case 0:
        {
            
            return 100;
        }
            break;
        case 1:
        {
            
            return 170;
        }
            break;
        default:
        {
            
            return 170;
        }
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消高亮
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    switch (_pageControl.currentPage)
    {
                    case 0:
        {
            Detail_ListViewController *dtVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"DetailVC"];
            //属性传值
            AItem *item = [AItem new];
            
            NSArray *imageArray = _dataSource[@"ListDataSource"];
            item = imageArray[indexPath.row];
            //文字段落处理
            NSString *content = item.content;
            NSMutableString *holderString = [NSMutableString stringWithString:@"+++++++"];
            NSMutableString *contentString = [NSMutableString stringWithString:content];
            for (NSInteger j = 0; j < 6; ++j)
            {
                contentString = [NSMutableString stringWithString:  [contentString stringByReplacingOccurrencesOfString:@"++++" withString:@"    "]];
                if (j < 4) {
                    NSString *string = [holderString substringFromIndex:j + 1];
                    
                    contentString = [NSMutableString stringWithString: [contentString stringByReplacingOccurrencesOfString:holderString withString:string] ];
                    
                    // holderString = [NSMutableString stringWithString:string];
                }
                
                if (j == 5)
                {
                    contentString = [NSMutableString stringWithString: [contentString stringByReplacingOccurrencesOfString:@"++" withString:@"\n    "]];
                    contentString = [NSMutableString stringWithString: [contentString stringByReplacingOccurrencesOfString:@"&nbsp;+" withString:@""]];
                    contentString = [NSMutableString stringWithString: [contentString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""]];
                    contentString = [NSMutableString stringWithString:  [contentString stringByReplacingOccurrencesOfString:@"+" withString:@"    "]];
                }
                
            }
            dtVC.str = contentString;
            dtVC.pic = item.images.firstObject;
            dtVC.newsId = item.newsId;
            
            [self.navigationController pushViewController:dtVC animated:YES];
        }
            break;
            
        case 1:
        {
            ImageViewController *imageVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ImageVC"];
            
            //属性传值
            AItem *item = [AItem new];
            NSArray *imageArray = _dataSource[@"ImageNewsDataSource"];
            item = imageArray[indexPath.row];
            imageVC.imageArray = item.images;
            imageVC.infoArray = item.infos;
            imageVC.title = item.title;
            imageVC.newsId = item.newsId;
            
            imageVC.view.backgroundColor = [UIColor blackColor];
            
            [self.navigationController pushViewController:imageVC animated:YES];
            
        }
            
            break;
        default:
            break;
    }
    
    
}
#pragma mark - CELL中点击播放按钮的代理
-(void)moviePlayDelegateFromCell:(id)sender{
    VideoCell *cell = (VideoCell *)sender;
    if (indexPaths && cell.indexPath != indexPaths) {
        [tableView3 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    movieView = cell.movieView;
    urlStr = cell.urlStr;
    indexPaths = cell.indexPath;
    
}

#pragma mark - 上拉加载更多

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //上拉加载更多
    
    self.ListBut.enabled = NO;
    self.imgBut.enabled = NO;
    self.videoBut.enabled = NO;
    
    switch (_pageControl.currentPage) {
        case 0:
            [qshRefreshView1 qshRefreshScrollViewDidScroll:scrollView];
        if (scrollView.contentOffset.y >= fmaxf(.0f, scrollView.contentSize.height - scrollView.frame.size.height) + 50)
            {
            NSLog(@"拉动加载更多");
                NSString *UrlWithString = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/news.api.php?act=list&page=%ld&count=10",++_i];
            
                [self getDataSource:UrlWithString];
            }
            break;
        case 1:
            [qshRefreshView2 qshRefreshScrollViewDidScroll:scrollView];
            if (scrollView.contentOffset.y >= fmaxf(.0f, scrollView.contentSize.height - scrollView.frame.size.height) + 50)
            {
                NSLog(@"拉动加载更多");
                NSString *UrlWithString = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/news.api.php?act=imgNewsList&page=%ld&count=5&cid=3",++_j];
                
                [self getDataSource:UrlWithString];
            }
            break;
        default:
        {
            [qshRefreshView3 qshRefreshScrollViewDidScroll:scrollView];
            if (scrollView.contentOffset.y >= fmaxf(.0f, scrollView.contentSize.height - scrollView.frame.size.height) + 50)
            {
                NSLog(@"拉动加载更多");
                NSString *UrlWithString = [NSString stringWithFormat:@"http://knews.sinaapp.com/api-2/news.api.php?act=videoList&page=%ld&count=10&cid=4",++_k];
                [self getDataSource:UrlWithString];
                
            }

            if (!indexPaths) {
                return;
            }
            CGRect rectInTableView = [tableView3 rectForRowAtIndexPath:indexPaths];
            CGRect rectInSuperview = [tableView3 convertRect:rectInTableView toView:[tableView3 superview]];
            UITableViewCell *cell = [self tableView:tableView3 cellForRowAtIndexPath:indexPaths];
            float height = cell.frame.size.height;
            if (rectInSuperview.origin.y <= -height || rectInSuperview.origin.y >= tableView3.frame.size.height) {
                [movieView.moviePlayer stop];
            }
            
        }
            break;
    }
    
    
}

#pragma mark - 视图滚动与按钮冲突的解决方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.ListBut.enabled = YES;
    self.imgBut.enabled = YES;
    self.videoBut.enabled = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.ListBut.enabled = YES;
    self.imgBut.enabled = YES;
    self.videoBut.enabled = YES;
}

#pragma mark - 下拉刷新方法
//数据刷新方法
-(void)getDataSource:(NSString*)url
{
    
        DataSouceDelegate *dataSourceDelegate = [DataSouceDelegate new];
        dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(aQueue, ^{
            NSData *aData = [dataSourceDelegate getData:url];
        
        switch (_pageControl.currentPage){
            case 0:
            {
                NSArray *ListDataSource = [self analysisData_List:aData];
                if ([url rangeOfString:@"page=0"].location == NSNotFound)
                {
                    //解析数据
                    NSArray *data = _dataSource[@"ListDataSource"];
                    NSArray *newData = [data arrayByAddingObjectsFromArray:ListDataSource];
                    [_dataSource setObject:newData forKey:@"ListDataSource"];
                }
                else
                {
                    [_dataSource setObject:ListDataSource forKey:@"ListDataSource"];
                    _i = 0;
                }
                //解析完刷新数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView1 reloadData];
                });
                
            }
                break;
            case 1:
            {
                NSArray *ListDataSource = [self analysisData_List:aData];
                if ([url rangeOfString:@"page=0"].location == NSNotFound)
                {
                    //解析数据
                    NSArray *data = _dataSource[@"ImageNewsDataSource"];
                    NSArray *newData = [data arrayByAddingObjectsFromArray:ListDataSource];
                    [_dataSource setObject:newData forKey:@"ImageNewsDataSource"];
                }
                else
                {
                    [_dataSource setObject:ListDataSource forKey:@"ImageNewsDataSource"];
                    _i = 0;
                }
                //解析完刷新数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView2 reloadData];
                });

            }
                break;
            default:
            {
                NSArray *ListDataSource = [self analysisData_List:aData];
                if ([url rangeOfString:@"page=0"].location == NSNotFound)
                {
                    //解析数据
                    NSArray *data = _dataSource[@"VideoNewsDataSource"];
                    NSArray *newData = [data arrayByAddingObjectsFromArray:ListDataSource];
                    [_dataSource setObject:newData forKey:@"VideoNewsDataSource"];
                }
                else
                {
                    [_dataSource setObject:ListDataSource forKey:@"VideoNewsDataSource"];
                    _i = 0;
                }
                //解析完刷新数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView3 reloadData];
                });
            }
                break;
        }
    });
}
//设置成要加载
- (void)reloadTableViewDataSource{
    NSString *url;
    switch (_pageControl.currentPage) {
        case 0:
        {
            url = @"http://knews.sinaapp.com/api-2/news.api.php?act=list&page=0&count=20";
        }
            break;
        case 1:
        {
            url = @"http://knews.sinaapp.com/api-2/news.api.php?act=imgNewsList&page=0&count=5&cid=3";
        }
            break;
        default:
        {
            url = @"http://knews.sinaapp.com/api-2/news.api.php?act=videoList&page=0&count=10&cid=4";
        }
            break;
    }
    [self getDataSource:url];
    _reloading = YES;
    //处理加载完成后的事件
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
    
}

//加载结束，设置成不要加载
- (void)doneLoadingTableViewData{
    
    _reloading = NO;
    switch (_pageControl.currentPage) {
        case 0:
            [qshRefreshView1 qshRefreshScrollViewDataSourceDidFinishedLoading:tableView1];
            break;
        case 1:
            [qshRefreshView2 qshRefreshScrollViewDataSourceDidFinishedLoading:tableView2];
            break;
        default:
            [qshRefreshView3 qshRefreshScrollViewDataSourceDidFinishedLoading:tableView3];
            break;
    }
    
    
}




//结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    switch (_pageControl.currentPage) {
        case 0:
            [qshRefreshView1 qshRefreshScrollViewDidEndDragging:scrollView];
            break;
        case 1:
            [qshRefreshView2 qshRefreshScrollViewDidEndDragging:scrollView];
            break;
        default:
            [qshRefreshView3 qshRefreshScrollViewDidEndDragging:scrollView];
            break;
    }
    
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
