//
//  SearchResultTableViewController.m
//  UI_8_5
//
//  Created by Ibokan_Teacher on 15/9/25.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SearchResultTableViewController.h"

@interface SearchResultTableViewController ()
{
    //存储搜索结果的数组
    NSMutableArray *_resultData;
}
@end

@implementation SearchResultTableViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化结果数组
    _resultData = [NSMutableArray new];
    //设置视图边缘
    self.edgesForExtendedLayout &= ~UIRectEdgeTop;
    
    
    //注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"result"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"result" forIndexPath:indexPath];
    
    cell.textLabel.text = _resultData[indexPath.row];
    
    return cell;
}


#pragma mark - 搜索控制器发生搜索行为时执行的代理方法
//必须实现
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"update");
}



#pragma mark - 搜索框代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //清空结果数组
    [_resultData removeAllObjects];
    
    NSString *searchText = searchBar.text;
    
    //从原始数据中筛选符合的数据加入到结果中
    for (NSString *aName in self.originalData)
    {
        if ([aName rangeOfString:searchText].location != NSNotFound)
        {
            [_resultData addObject:aName];
        }
    }
    
    //重新加载表视图
    [self.tableView reloadData];
}


#pragma mark - 搜索控制器进入搜索状态时的代理方法
- (void)didPresentSearchController:(UISearchController *)searchController
{
    //清空结果数据，重新加载表视图
    [_resultData removeAllObjects];
    
    [self.tableView reloadData];
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

@end
