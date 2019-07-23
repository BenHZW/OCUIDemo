//
//  RootViewController.m
//  UI_8_4
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    //表视图
    UITableView *_tableView;
    
    //数据源
    NSMutableArray *_names;
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //1.能让表视图进入/退出编辑状态的按钮
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.view addSubview:editButton];
    
    editButton.frame = CGRectMake(20, 370, 70, 40);
    [editButton setTitle:@"edit" forState:UIControlStateNormal];
    
    [editButton addTarget:self action:@selector(editButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //2.表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, 300, 360)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"name"];
    
    
    //3.初始化数据源
    _names = [NSMutableArray arrayWithArray:@[@"蔡恒诚", @"蔡梓锋", @"陈奕智", @"范凤涛", @"辜东明", @"郭展富", @"何福威", @"黄嘉龙", @"黄智文", @"邝健锋", @"李宇婷", @"林宇", @"苏文略", @"翁灿资", @"伍宏伟", @"于其亮", @"张振杰", @"钟保", @"邹耀成", @"肖梓浩", @"刘林强", @"罗杰", @"叶镇明", @"汤正礼", @"周少聪", @"郑伟超"]];
    
}


#pragma mark - 编辑按钮的方法
- (void)editButtonPressed
{
    //让表视图进入/退出编辑状态
    BOOL editingState = _tableView.isEditing;
    
    [_tableView setEditing:!editingState animated:YES];
}

#pragma mark - 表视图代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"name" forIndexPath:indexPath];
    
    cell.textLabel.text = _names[indexPath.row];
    
    return cell;
}


#pragma mark - 与表视图编辑相关的方法

//指定各行分别应该进入何种编辑状态
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可以根据indexPath决定不同行进入不同的编辑状态
    
    
    //假如让前7行进入插入状态，其余进入删除状态
    if (indexPath.row < 7)
    {
        return UITableViewCellEditingStyleInsert;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
    
}


//指定各行是否能够进入编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //假设就让第5行不能编辑，其余可以
    if (indexPath.row == 4)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


//确认编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //利用传入的编辑状态和indexPath，自行决定需要做什么事情
    
    
    //例如，判断插入或删除操作
    switch (editingStyle)
    {
        case UITableViewCellEditingStyleDelete: //删除操作
        {
            //删除对应的数据源
            [_names removeObjectAtIndex:indexPath.row];
            
            //将对应的单元格删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            
        }
            break;
            
        case UITableViewCellEditingStyleInsert: //插入操作
        {
            //假设插入的都是newName
            NSString *newName = @"newName";
            
            //插入到数据源
            [_names insertObject:newName atIndex:indexPath.row];
            
            //插入单元格
            [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            
        }
            break;
            
            
        default:
            break;
    }
}

//返回删除按钮文字的方法
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma mark - 表视图单元格移动相关的代理方法

//决定各行单元格是否能移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    //假设前3行不能移动
    if (indexPath.row < 3)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


//决定一个单元格被拖动后，最终该移动到哪里
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    //判断松手时的目标indexPath是否允许（因为前3行不能移动）
    
    //如果目标indexPath是前3行
    if (proposedDestinationIndexPath.row < 3)
    {
        //不允许的移动
        //从哪里来回哪里去
        return sourceIndexPath;
    }
    else
    {
        //允许留在目标位置
        return proposedDestinationIndexPath;
    }
}


//单元格移动之后要执行的方法
- (void)tableView:(UITableView *)tableView  moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //更新数据源
    
    id data = _names[sourceIndexPath.row];
    
    //从数组中移除这个数据
    [_names removeObjectAtIndex:sourceIndexPath.row];
    
    //将这个数据插入到数组中新的位置
    [_names insertObject:data atIndex:destinationIndexPath.row];
}



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
