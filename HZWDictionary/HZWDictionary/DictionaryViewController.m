//
//  DictionaryViewController.m
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "DictionaryViewController.h"
#import "DictionaryRequestModel.h"
#import "IdiomCell.h"
#import "DictionaryCell.h"

@interface DictionaryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_showTableView;
    NSMutableArray *_datasource;
    UITextField *_searchTextField;
}
@end

@implementation DictionaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"生字查找";
    UILabel *searchLabel = [[UILabel alloc] init];
    searchLabel.text = @"字";
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
    _searchTextField.placeholder = @"需要搜索的字";
    _searchTextField.backgroundColor = [UIColor redColor];
    _searchTextField.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_searchTextField];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(searchLabel.mas_right).with.offset(10);
        make.width.mas_equalTo(120);
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
    NSLog(@"字典查找");
}

- (void)showTheData
{
    [DictionaryRequestModel dictionaryParamters:@{@"key":@"fa710e7e93b4", @"name":_searchTextField.text} andCallback:^(NSDictionary *dic)
     {
         NSLog(@"%@",dic);
         _datasource = [[NSMutableArray alloc] init];
         if (dic[@"bihua"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"bihua"]];
         }
         
         if (dic[@"bihuaWithBushou"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"bihuaWithBushou"]];
         }
         
         if (dic[@"brief"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"brief"]];
         }
         
         if (dic[@"bushou"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"bushou"]];
         }
         
         if (dic[@"detail"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"detail"]];
         }
         
         if (dic[@"name"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"name"]];
         }

         if (dic[@"pinyin"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"pinyin"]];
         }
         
         if (dic[@"wubi"] == nil)
         {
             [_datasource addObject:@""];
         }
         else
         {
             [_datasource addObject:dic[@"wubi"]];
         }
         [_showTableView reloadData];
     }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DictionaryCell *cell = nil;
    cell = [tableView  dequeueReusableCellWithIdentifier:@"DCell"];
    if (cell == nil)
    {
        cell = [[DictionaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DCell"];
    }
    if (indexPath.row == 0)
    {
        cell.dicLabel.text = @"笔画";
    }
    if (indexPath.row == 1)
    {
        cell.dicLabel.text = @"笔画部首";
    }
    if (indexPath.row == 2)
    {
        cell.dicLabel.text = @"详细";
    }
    if (indexPath.row == 3)
    {
        cell.dicLabel.text = @"左边部首";
    }
    if (indexPath.row == 4)
    {
        cell.dicLabel.text = @"析意";
    }
    if (indexPath.row == 5)
    {
        cell.dicLabel.text = @"名字";
    }
    if (indexPath.row == 6)
    {
        cell.dicLabel.text = @"拼音";
    }
    if (indexPath.row == 7)
    {
        cell.dicLabel.text = @"五笔";
    }
    cell.showLabel.text = [NSString stringWithFormat:@"%@", _datasource[indexPath.row]];
    return cell;
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
