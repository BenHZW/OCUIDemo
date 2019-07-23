//
//  SearchDisplayDelegate.m
//  UI_8_5
//
//  Created by Ibokan_Teacher on 15/9/25.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SearchDisplayDelegate.h"

@interface SearchDisplayDelegate ()
{
    //存放搜索结果数据的数组
    NSMutableArray *_resultData;
}
@end

@implementation SearchDisplayDelegate

#pragma mark - 初始化

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //初始化结果数组
        _resultData = [NSMutableArray new];
    }
    return self;
}

- (instancetype)initWithSearchDisplayController:(UISearchDisplayController *)searchDisplayController
{
    self = [self init];
    if (self)
    {
        //设置委托人的引用
        _searchDisplayController = searchDisplayController;
        
        //将委托人的代理设置为自身
        _searchDisplayController.delegate = self;
        _searchDisplayController.searchResultsTableView.dataSource = self;
        
        _searchDisplayController.searchResultsTableView.delegate = self;
        
        _searchDisplayController.searchBar.delegate = self;
        
        //为搜索结果表视图注册单元格
        [_searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"result"];
    }
    
    return self;
}

#pragma mark - 搜索结果表视图代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"result" ];
    
    cell.textLabel.text = _resultData[indexPath.row];
    
    return cell;
}


#pragma mark - 搜索框的代理方法

//搜索框按下搜索按钮时执行
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //清空搜索结果数组的数据
    [_resultData removeAllObjects];
    
    
    NSString *searchText = searchBar.text;
    
    //从原始数据中按照一定的逻辑筛选数据，加入到搜索结果数组中
    for (NSString *aName in self.originalData)
    {
        //搜索aName是否包含searchText
        if ([aName rangeOfString:searchText].location != NSNotFound)
        {
            [_resultData addObject:aName];
        }
    }
    
    //重新加载搜索结果表视图
    [self.searchDisplayController.searchResultsTableView reloadData];
}



#pragma mark - 搜索展示控制器的代理方法
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    //清空搜索结果数据并重新加载表视图
    [_resultData removeAllObjects];
    
    [controller.searchResultsTableView reloadData];
}





@end














