//
//  RootTableViewController.m
//  UI_8_5
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootTableViewController.h"
#import "SearchResultTableViewController.h"

@interface RootTableViewController ()
{
    //数据源
    NSMutableArray *_names;
    
    //搜索控制器
    UISearchController *_searchController;
}
@end

@implementation RootTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout &= ~UIRectEdgeTop;
    
    
    //所有控制器都自带一个editButtonItem
    //表视图的这个item能让表视图进入/退出编辑状态
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //初始化数据源
    _names = [NSMutableArray arrayWithArray:@[@"蔡恒诚", @"蔡梓锋", @"陈奕智", @"范凤涛", @"辜东明", @"郭展富", @"何福威", @"黄嘉龙", @"黄智文", @"邝健锋", @"李宇婷", @"林宇", @"苏文略", @"翁灿资", @"伍宏伟", @"于其亮", @"张振杰", @"钟保", @"邹耀成", @"肖梓浩", @"刘林强", @"罗杰", @"叶镇明", @"汤正礼", @"周少聪", @"郑伟超"]];
    
    
    
    
    //增加一个删除按钮
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteButtonPressed)];
    self.navigationItem.leftBarButtonItem = deleteItem;
    
    
    //注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"name"];
    
    
    
    //------------以上是旧内容-----------------
    
    //创建搜索结果表视图控制器
    SearchResultTableViewController *srtvc = [SearchResultTableViewController new];
    //传入原始数据
    srtvc.originalData = _names;
    
    
    
    //搜索控制器的使用（仅iOS8之后）
    _searchController = [[UISearchController alloc] initWithSearchResultsController:srtvc];
    //设置代理
    _searchController.searchResultsUpdater = srtvc;
    _searchController.delegate = srtvc;
    _searchController.searchBar.delegate = srtvc;
    
    
    //自动调整搜索框大小
    [_searchController.searchBar sizeToFit];
    
    
    //搜索框显示在表头
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    
    
}

#pragma mark - 删除按钮
- (void)deleteButtonPressed
{
    //1.获取被选中的单元格的indexPath
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    //数组中的indexPath的顺序是按照用户点选的先后顺序排列的
    
    
    //2.删除数据源应有序地进行（从后往前）
    //对上述的indexPaths进行排序(NSIndexPath已实现了标准compare:方法，可直接用于排序)
    NSArray *sortedIndexPaths = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
    
    
    //从后往前遍历排好序的数组，删除对应的数据源
    for (NSInteger i = sortedIndexPaths.count - 1; i >= 0; --i)
    {
        //取出一个indexPath
        NSIndexPath *anIndexPath = sortedIndexPaths[i];
        
        //删除数组中对应的元素
        [_names removeObjectAtIndex:anIndexPath.row];
    }
    
    
    //3.删掉这些indexPath对应的单元格
    [self.tableView deleteRowsAtIndexPaths:sortedIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"name" forIndexPath:indexPath];
    
    cell.textLabel.text = _names[indexPath.row];
    
    return cell;
}


//决定单元格进入哪种编辑状态
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //样式3就是多选状态
    return 3;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
