//
//  JSONTableViewController.m
//  UI_12_2
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "JSONTableViewController.h"
#import "user.h"
@interface JSONTableViewController ()
{
     //数据源
    NSArray *_users;
    
 
  

}
@end

@implementation JSONTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //一般而言，解析数据的步骤应该写在网络下载完成之时，不是写在viewDidLoad
    //但本例抓住重点，JSON数据直接从本地文件获得，不涉及网络请求，所以在此处解析
    
    //1.通过某种途径(网络请求等)获得JSON数据
    NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"user" ofType:@"json" ];
    NSLog(@"-----%@",dataPath);
    
    //这个JSON数据用NSData表示即可
    
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:dataPath];
    
    
    //2.把整个JSON数据转换成字典与数组的结构
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
   //3.按照层次结构进行解析
   //3.1.获取System_User键对应的数组
    NSArray *system_users  = jsonDict[@"System_Users"];
    
    //3.2.数组里面有三个字典,分别代表三个User的信息
    
    //一个存放User对象的临时数组
    NSMutableArray *tempUsers = [[NSMutableArray alloc] initWithCapacity:system_users.count];
    
    //遍历system_users数组
    for (NSDictionary *aUserDict in system_users)
    {
        //取出这个字典的object构建一个User对象
        
        User *aUser = [User new];
        aUser.userID = [aUserDict[@"id"]integerValue];
        aUser.firstName = aUserDict[@"firstname"];
        aUser.height = [aUserDict[@"height"]doubleValue];
        //........
        [tempUsers addObject:aUser];
    
    }
    
    //4.设定数据源
    _users = [NSArray arrayWithArray:tempUsers];
    
    
    //5.刷新表视图
    [self.tableView reloadData];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];
    
   //改行对应的User对象
    User *theUser = _users[indexPath.row];
    
    //根据需要在单元格上显示信息
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %.2f",theUser.firstName,theUser.height];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%03ld",theUser.userID];
    
    
    
    
    return cell;
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
