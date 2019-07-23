//
//  RootTableViewController.m
//  UI_8_2
//
//  Created by Ibokan_Teacher on 15/9/22.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()
{
    //记录分组数据的字典
    NSDictionary *_groupedStudents;
    
    //另外用一个数组按顺序记录字典的key
    NSArray *_allGroupKeys;
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //1.注册单元格类型
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"students"];
    
    //2.通过某种途径获得数据源
    _groupedStudents = @{
        @"A":@[@"蔡恒诚", @"蔡梓锋", @"陈奕智", @"范凤涛", @"辜东明", @"郭展富"],
        @"B":@[@"何福威", @"黄嘉龙", @"黄智文"],
        @"C":@[@"邝健锋", @"李宇婷", @"林宇", @"苏文略", @"翁灿资", @"伍宏伟", @"于其亮", @"张振杰", @"钟保",],
        @"D":@[@"邹耀成", @"肖梓浩", @"刘林强", @"罗杰"]
    };
    
    //按顺序记录所有的key
    _allGroupKeys = [_groupedStudents.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    
    //3.header和footer
    
    //3.1.整个表的header和footer
    
    UILabel *tableHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    tableHeaderLabel.text = @"表头";
    tableHeaderLabel.backgroundColor = [UIColor redColor];
    
    self.tableView.tableHeaderView = tableHeaderLabel;
    
    //表尾tableFooterView请自行尝试
    
    
    
    //3.2.分区头和分区尾
    /*
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.sectionFooterHeight = 30;
    
    //用View作为头或尾，需要运用重用机制
    //注册头或尾使用的View的类型
    //iOS提供一个专门适合做头和尾的控件
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header_footer"];
    */
    
    
    //3.2.ex.如果分区头或尾只要显示文字，则可以用另外一个代理方法来实现，此时不需要注册分区头或尾
    //另外也不能使用viewForHeader...或viewForFooter...方法
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - 返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //这是可选的代理方法，返回表视图共有多少个分区，如果不实现这个方法，默认是1个分区
    return _allGroupKeys.count;
}

#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //根据section的不同返回不同的行数
    
    //NSString *sectionKey = _allGroupKeys[section];
    
    NSArray *sectionMembers = _groupedStudents[_allGroupKeys[section]];
    
    return sectionMembers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"students" forIndexPath:indexPath];
    
    //根据indexPath从字典中取出对应的名字
    NSString *sectionKey = _allGroupKeys[indexPath.section];
    
    NSArray *sectionMembers = _groupedStudents[_allGroupKeys[indexPath.section]];
    
    NSString *studentName = sectionMembers[indexPath.row];
    
    cell.textLabel.text = studentName;
    
    
    return cell;
}

#pragma mark - 返回每一个分区头各自的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}



#pragma mark - 返回每个分区头的View
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //使用重用机制根据标识符取出可重用的头或尾的View（如果没有会自动创建）
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header_footer"];
    
    //设置这个View的相关效果
    headerView.textLabel.text = _allGroupKeys[section];
    
    
    return headerView;
}
 */


#pragma mark - 返回每个分区头要显示的文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _allGroupKeys[section];
}


#pragma mark - 返回表视图右侧索引条的文字的数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _allGroupKeys;
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
