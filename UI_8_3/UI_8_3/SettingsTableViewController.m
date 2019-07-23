//
//  SettingsTableViewController.m
//  UI_8_3
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SwitchTableViewCell.h"
#import "TextSwitch.h"

@interface SettingsTableViewController ()
{
    //数据源
    NSArray *_cellData;
}
@end

@implementation SettingsTableViewController

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
    
    self.tableView.rowHeight = 180;
    
    
    //注册单元格类型
    //不同类型的单元格使用不同的标识符
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normal"];
    
    [self.tableView registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:@"switch"];
    
    
    
    
    //初始化数据源
    TextSwitch *wifi = [TextSwitch textSwitchWithString:@"Wi-Fi" isOnState:NO];
    TextSwitch *blueTooth = [TextSwitch textSwitchWithString:@"蓝牙" isOnState:NO];
    TextSwitch *blockingMode = [TextSwitch textSwitchWithString:@"阻止模式" isOnState:NO];
    
    //将所有的模型放入数组
    _cellData = @[wifi, blueTooth, @"更多数据", @"其他设置", @"主屏模式", blockingMode, @"声音", @"显示", @"安全选项"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出对应行的模型
    id model = _cellData[indexPath.row];
    
    
    //根据不同类型的模型，返回不同类型的单元格
    if ([model isKindOfClass:[TextSwitch class]])
    {
        NSLog(@"要使用开关单元格");
        
        //取出可重用的单元格
        SwitchTableViewCell *scell = [tableView dequeueReusableCellWithIdentifier:@"switch" forIndexPath:indexPath];
        
        //直接将自定义模型赋值给单元格
        scell.textSwitch = model;
        
        return scell;
    }
    else
    {
        NSLog(@"要使用普通单元格");
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
        
        //这时候的模型应该是个字符串
        cell.textLabel.text = model;
        
        return cell;
    }
    
    
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
