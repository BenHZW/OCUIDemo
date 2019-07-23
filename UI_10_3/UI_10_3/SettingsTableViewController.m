//
//  SettingsTableViewController.m
//  UI_10_3
//
//  Created by Ibokan_Teacher on 15/9/29.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SwitchTableViewCell.h"
#import "TextSwitch.h"
#import "SetViewController.h"

@interface SettingsTableViewController ()
{
    //数据源
    NSArray *_cellData;
}

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据源
    TextSwitch *wifi = [TextSwitch textSwitchWithString:@"Wi-Fi" isOnState:NO];
    TextSwitch *blueTooth = [TextSwitch textSwitchWithString:@"蓝牙" isOnState:NO];
    TextSwitch *blockingMode = [TextSwitch textSwitchWithString:@"阻止模式" isOnState:NO];
    
    //将所有的模型放入数组
    _cellData = @[wifi, blueTooth, @"更多数据", @"其他设置", @"主屏模式", blockingMode, @"声音", @"显示", @"安全选项"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return _cellData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出数据源
    id data = _cellData[indexPath.row];
    
    if ([data isKindOfClass:[TextSwitch class]])
    {
        SwitchTableViewCell *scell = [tableView dequeueReusableCellWithIdentifier:@"switch" forIndexPath:indexPath];
        
        scell.textSwitch = data;
        
        return scell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
        
        cell.textLabel.text = data;
        
        return cell;
    }
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

#pragma mark - 开关视图控制器代理方法
- (void)switchViewController:(SwitchViewController *)controller
{
    //取出对应的indexPath
    NSIndexPath *cellIndexPath = controller.cellIndexPath;
    
    //刷新对应indexPath的单元格即可
    [self.tableView reloadRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //利用标识符判断不同的连线
    if ([segue.identifier isEqualToString:@"normal"])
    {
        //取出目标的视图控制器
        SetViewController *svc = segue.destinationViewController;
        
        //本连线中，动作的执行者sender就是那个单元格
        UITableViewCell *cell = sender;
        
        svc.title = cell.textLabel.text;
    }
    else if([segue.identifier isEqualToString:@"switch"])
    {
        //此处的目标视图控制器是带有开关的那种
        SwitchViewController *svc = segue.destinationViewController;
        
        //sender就是被点击的单元格
        SwitchTableViewCell *scell = sender;
        
        //获取此单元格的indexPath
        NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:scell];
        
        //传值
        svc.textSwitch = scell.textSwitch;
        svc.cellIndexPath = cellIndexPath;
        
        //设置代理
        svc.delegate = self;
    }
}







@end



