//
//  SearchResultTableViewController.h
//  UI_8_5
//
//  Created by Ibokan_Teacher on 15/9/25.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于显示搜索结果
//兼任搜索控制器、搜索框的代理人
@interface SearchResultTableViewController : UITableViewController<UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate>

//原始数据，弱引用
@property(nonatomic, assign)NSArray *originalData;


@end











