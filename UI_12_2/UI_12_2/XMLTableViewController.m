

//
//  XMLTableViewController.m
//  UI_12_2
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XMLTableViewController.h"
#import "User.h"
#import "GDataXMLNode.h"
@interface XMLTableViewController ()
{
    //数据源
    NSArray *_users;
   

}

@end

@implementation XMLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //同样地，解析XML的过程与网络请求无关
    //但XML的数据通常来自网络请求下载
    //本例解析的是本地数据
    
    //1.从某种途径获得XML数据
    NSString *xmlPath = [[NSBundle mainBundle]pathForResource:@"user" ofType:@"xml"];
    
    NSData *xmlData  =  [[NSData alloc] initWithContentsOfFile:xmlPath];
    

    //2.把XML数据整个转换成文档对象
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithData:xmlData options:XML_PARSE_NOBLANKS|XML_PARSE_NOCDATA error:nil];
    
    //3.下面开始解析，解析应该一次过在同一作用域中完成
    //3.1从文档对象获取跟节点
    GDataXMLElement *system_users = [xmlDocument rootElement];
    //3.2.在system_users节点下获取所有User节点
  NSArray *all_user_elements = [system_users elementsForName:@"User"];
    
    
    
    NSMutableArray *tempUsers = [[NSMutableArray alloc] initWithCapacity:all_user_elements.count];
    //3.3.遍历all_user_elements数组，循环解析每个User节点
    for (GDataXMLElement *aUserElement in all_user_elements)
    {
        //解析出name节点
        GDataXMLElement *nameElement = [aUserElement elementsForName:@"name"].firstObject;
        
     
        
        
        //再从name节点中解析出firstname节点
        GDataXMLElement *firstNameElement = [nameElement elementsForName:@"firstname"].firstObject;
      
        
        
        //解析出身高节点
        GDataXMLElement * heightElement =[aUserElement elementsForName:@"height"].firstObject;
        
         //解析节点头中的attribute
       GDataXMLNode *userIDNode = [aUserElement attributeForName:@"id"];
        
        //创建用户对象，并将解析得到的数据给它赋值
        User *aUser = [User new];
        aUser.firstName = firstNameElement.stringValue;
        aUser.height = heightElement.stringValue.doubleValue;
        aUser.userID = userIDNode.stringValue.integerValue;
        
        [tempUsers addObject:aUser];
    }
    
   
    _users = [NSArray arrayWithArray:tempUsers];
    
    
  
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];
    
  
    User *theUser = _users[indexPath.row];
    

    cell.textLabel.text = [NSString stringWithFormat:@"%@ %.2f",theUser.firstName,theUser.height];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%03ld",theUser.userID];
    
    
    return cell;
}




@end
