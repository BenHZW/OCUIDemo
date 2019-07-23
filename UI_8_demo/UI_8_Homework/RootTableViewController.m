//
//  RootTableViewController.m
//  UI-8-表视图6:分区
//
//  Created by Ibokan on 14-12-22.
//  Copyright (c) 2014年 fghf. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()
{
    //用来记录原始数据的字典，原始数据固定不变
    NSDictionary *_originalDataDict;
    
    //用来提供显示数据的字典，显示内容可变，因此使用可变字典
    NSMutableDictionary *_dataDictForShow;
    
    
    //空数组备用
    NSArray *_emptyArray;
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
    self.tableView.rowHeight = 55;
    
    
    //注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //注册分区头
    [self.tableView registerClass:[ButtonHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    
    _originalDataDict = @{
                  @"新闻媒体":@[@"人民网", @"CCTV", @"南方日报", @"中新网"],
                  @"手机购物":@[@"淘宝", @"天猫", @"1号点", @"京东"],
                  @"便民生活":@[@"充话费", @"打车", @"水电煤气", @"火车票"],
                  @"视频网站":@[@"优酷", @"土豆", @"56", @"乐视", @"爱奇艺"]
                };
    
    
    
    //初始化提供显示数据的字典，只要拷贝数据源的字典即可
    _dataDictForShow = [[NSMutableDictionary alloc] initWithDictionary:_originalDataDict];
    
    
    //初始化空数组
    _emptyArray = [NSArray new];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //返回字典的总的键值对数量，作为分区数
    return _dataDictForShow.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    //获得section（分区号）对应的分区key
    NSString *sectionKey = _dataDictForShow.allKeys[section];
    
    //通过key获得该分区下的数组
    NSArray *cellTitles = _dataDictForShow[sectionKey];
    
    //这个数组的元素个数，就是该分区的行数
    return cellTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    //根据indexPath中不同的分区、行，给予单元格不同的数据
    NSString *sectionKey = _dataDictForShow.allKeys[indexPath.section];
    NSArray *cellTitles = _dataDictForShow[sectionKey];
    
    
    //数组里元素的顺序跟行号是一样的
    cell.textLabel.text = cellTitles[indexPath.row];
    
    //设置单元格分级层次，可以让文字右移
    cell.indentationLevel = 2;
    
    
    return cell;
}


#pragma mark - 设置表视图分区头的代理方法

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //获取可重用的分区头
    ButtonHeaderView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
  
    
    
    //获取对应分区头的文本
    NSString *headerTitle = _dataDictForShow.allKeys[section];
    
    //设置分区头按钮文字
    headerView.buttonTitle = headerTitle;
    
    //设置分区头的tag值与当前分区相同，便于识别
    headerView.tag = section;
    
    //设置分区头代理
    headerView.delegate = self;
    
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}

#pragma mark - 分区头被点击时的代理方法
- (void)buttonHeaderViewDidPress:(ButtonHeaderView *)buttonHeaderView
{
    //按钮文字就是字典对应的分区名
    NSString *sectionKey = buttonHeaderView.buttonTitle;
    
    //无论插入或删除都要先更新数据源
    //插入：使对应分区下的数组为原始的数组（有数据）
    //删除：使对应分区下的数组为空数组（无数据）
    
    
    //如果该分区下无内容，则赋予源数据的数组
    if( _dataDictForShow[sectionKey] == _emptyArray )
    {
        _dataDictForShow[sectionKey] = _originalDataDict[sectionKey];
    }
    //如果该分区下有内容，则赋予该分区一个空数组
    else
    {
        _dataDictForShow[sectionKey] = _emptyArray;
    }
    
    
    //通过分区头的tag值获得分区号
    NSInteger section = buttonHeaderView.tag;
    
    
    //重新加载这个分区
    //要使用reloadSections:方法
    //其中要填入一个NSIndexSet对象，里面存放了要操作的index
    //于是使用对应的分区号section创建一个NSIndex对象，代入参数中
    //重新加载后就达到了插入/删除的效果了
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];        
}

@end











