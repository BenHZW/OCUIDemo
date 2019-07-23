//
//  SearchDisplayDelegate.h
//  UI_8_5
//
//  Created by Ibokan_Teacher on 15/9/25.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <UIKit/UIKit.h>

//这个类要担任搜索展示控制器的代理、搜索结果表视图的代理、搜索框的代理
@interface SearchDisplayDelegate : NSObject<UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

//为方便引用，这里对委托人进行强引用
@property(nonatomic, retain, readonly)UISearchDisplayController *searchDisplayController;

- (instancetype)initWithSearchDisplayController:(UISearchDisplayController*)searchDisplayController;


//原始数据，供搜索筛选时使用，数据直接来源于表视图控制器，自身不持有
@property(nonatomic, assign)NSArray *originalData;

@end













