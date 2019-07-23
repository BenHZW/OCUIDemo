//
//  IdiomViewController.m
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "IdiomViewController.h"
#import "IdiomRequestModel.h"
#import "IdiomCell.h"
@interface IdiomViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_showTableView;
    NSMutableArray *_datasource;
    UITextField *_searchTextField;
}
@end

@implementation IdiomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"成语查找";
    UILabel *searchLabel = [[UILabel alloc] init];
    searchLabel.text = @"成语";
    searchLabel.textAlignment = NSTextAlignmentCenter;
    searchLabel.font = [UIFont systemFontOfSize:23];
    [self.view addSubview:searchLabel];
    
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(self.view.mas_left).with.offset(30);
         make.width.mas_equalTo(@100);
         make.height.mas_equalTo(@50);
         make.top.mas_equalTo(self.view.mas_top).with.offset(100);
     }];
    
    _searchTextField = [[UITextField alloc] init];
    _searchTextField.placeholder = @"需要搜索的成语";
    _searchTextField.backgroundColor = [UIColor redColor];
    _searchTextField.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_searchTextField];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(searchLabel.mas_right).with.offset(10);
         make.width.mas_equalTo(140);
         make.top.mas_equalTo(searchLabel.mas_top);
         make.height.mas_equalTo(searchLabel.mas_height);
     }];
    
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor grayColor];
    searchButton.layer.cornerRadius = 6;
    [searchButton addTarget:self action:@selector(showTheData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_searchTextField.mas_right).with.offset(20);
         make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
         make.height.mas_equalTo(_searchTextField.mas_height);
         make.top.mas_equalTo(_searchTextField.mas_top);
     }];
    
    _showTableView = [[UITableView alloc] init];
    _showTableView.delegate = self;
    _showTableView.dataSource = self;
    [self.view addSubview:_showTableView];
    [_showTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(self.view.mas_left);
         make.right.mas_equalTo(self.view.mas_right);
         make.bottom.mas_equalTo(self.view.mas_bottom);
         make.top.mas_equalTo(searchButton.mas_bottom).with.offset(10);
     }];
   

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IdiomCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"ICell"];
    if (cell == nil)
    {
        cell = [[IdiomCell alloc] init];
        [tableView registerClass:[IdiomCell class] forCellReuseIdentifier:@"ICell"];
    }
    if (indexPath.row == 0)
    {
        cell.idiomLabel.text = @"名字";
    }
    if (indexPath.row == 1)
    {
        cell.idiomLabel.text = @"拼音";
    }
    if (indexPath.row == 2)
    {
        cell.idiomLabel.text = @"析意";
    }
    if (indexPath.row == 3)
    {
        cell.idiomLabel.text = @"用法";
    }
    if (indexPath.row == 4)
    {
        cell.idiomLabel.text = @"来源";
    }
    if (indexPath.row == 5)
    {
        cell.idiomLabel.text = @"古典解意";
    }
    cell.showLabel.text = [NSString stringWithFormat:@"%@",_datasource[indexPath.row]];
    return cell;
}

- (void)showTheData
{
    [IdiomRequestModel idiomParameters:@{@"key":@"fa710e7e93b4",@"name":_searchTextField.text} andCallback:^(NSDictionary *dic)
     {
         _datasource = [[NSMutableArray alloc] init];
         if (dic[@"name"] == nil)
         {
             [_datasource addObject:@" "];
         }
         else
         {
             [_datasource addObject:dic[@"name"]];
         }
         
         if (dic[@"pretation"] == nil)
         {
             [_datasource addObject:@" "];
         }
         else
         {
             [_datasource addObject:dic[@"pretation"]];
         }
         
         if (dic[@"pinyin"] == nil)
         {
             [_datasource addObject:@" "];
         }
         else
         {
             [_datasource addObject:dic[@"pinyin"]];
         }
         
         if (dic[@"sample"] == nil)
         {
             [_datasource addObject:@" "];
         }
         else
         {
             [_datasource addObject:dic[@"sample"]];
         }
         
         if (dic[@"sampleFrom"] == nil)
         {
             [_datasource addObject:@" "];
         }
         else
         {
             [_datasource addObject:dic[@"sampleFrom"]];
         }
         if (dic[@"source"] == nil)
         {
             [_datasource addObject:@" "];
         }
         else
         {
             [_datasource addObject:dic[@"source"]];
         }
         [_showTableView reloadData];
     }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
