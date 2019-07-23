//
//  ShowTableViewController.m
//  HZWHistory
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "ShowTableViewController.h"
#import "HZWRequestModel.h"
#import "HZWjsonModel.h"
#import "ShowTableViewCell.h"
@interface ShowTableViewController()
{
    NSMutableDictionary *_datasource;
}
@end

@implementation ShowTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _datasource = [[NSMutableDictionary alloc] init];
    [HZWRequestModel searchParameters:@{@"day":self.date} andCallback:^(NSArray *categorySearchModel)
     {
         for (HZWCategorySearchModel *hzwCSM in categorySearchModel)
         {
              NSMutableArray *dataArray = [[NSMutableArray alloc] init];
             [dataArray addObject:hzwCSM.day];
             [dataArray addObject:hzwCSM.event];
             [dataArray addObject:hzwCSM.Id];
             [dataArray addObject:hzwCSM.month];
             [dataArray addObject:hzwCSM.title];
             [_datasource setObject:dataArray forKey:hzwCSM.date];
         }
         [self.tableView reloadData];
     }];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *arr = _datasource.allKeys;
    return arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_datasource objectForKey: _datasource.allKeys[section]];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"forIndexPath:indexPath];
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor grayColor]];
        [cell setSelectedBackgroundView:view];
        NSArray *currentArray = [_datasource objectForKey:_datasource.allKeys[indexPath.section]];
        cell.event.text =  [NSString stringWithFormat:@"发生事件详情:%@",currentArray[indexPath.row] ];
        return cell;
    }
    else
    {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell"];
    
        if (cell == nil)
    
        {
        
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"otherCell"];
        
            UIView *view = [[UIView alloc] init];
        
            [view setBackgroundColor:[UIColor grayColor]];
           
            
        }
        NSArray *currentArray = [_datasource objectForKey: _datasource.allKeys[indexPath.section]];
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@日",currentArray[indexPath.row]];
            return cell;
        }
        if (indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"编号:%@",currentArray[indexPath.row]];
             return cell;
        }
        if (indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@月",currentArray[indexPath.row]];
             return cell;
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"标题:%@",currentArray[indexPath.row]];
            return cell;
        }
    }
    
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
    return  _datasource.allKeys[section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return 300;
    }
    return 100;
}

@end
