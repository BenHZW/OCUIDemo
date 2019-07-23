//
//  SettingTableViewController.m
//  New UI
//
//  Created by gdm on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SettingTableViewController.h"

NSString *const SettingNightMode = @"SettingNightMode";

@interface SettingTableViewController ()
{
    //夜间模式按钮
    UISwitch *_nightModeSwitch;
}
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"设置";
    _nightModeSwitch = [[UISwitch alloc]initWithFrame: CGRectMake(0, 5, 100, 70)];
    
   
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults]valueForKey:@"setOrCancelNightMode"];
    
    _nightModeSwitch.on = number.integerValue;
    
    [_nightModeSwitch addTarget:self action:@selector(sendingNotification:) forControlEvents:UIControlEventValueChanged];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if ((indexPath.section == 0) && (indexPath.row == 0))
    {
        cell.textLabel.text = @"夜间模式";
        
       // CGRect rectOfcell = cell.frame;
        
        cell.accessoryView = _nightModeSwitch;
        
    }
    
    if ((indexPath.section == 0) && (indexPath.row == 1))
    {
        cell.textLabel.text = @"关于新闻";
    }

    else
    cell.textLabel.text = @"开发中，尽请期待！";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    if ((indexPath.section == 0) && (indexPath.row == 1))
    {
        //提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"news for iOS 9.1" message:@"新手上路，功能简陋" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
        }];
        
        [alertController addAction:ok];
        
        //以模态视图呈现
        [self presentViewController:alertController animated:YES completion:nil];
        
    }

}

- (void)sendingNotification:(UISwitch*)send
{
    self.setOrCancelNightMode = send.isOn;
    [[NSNotificationCenter defaultCenter]postNotificationName:SettingNightMode object:self userInfo:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *number = [NSNumber numberWithBool:self.setOrCancelNightMode];
    
    [defaults setValue:number forKeyPath:@"setOrCancelNightMode"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
