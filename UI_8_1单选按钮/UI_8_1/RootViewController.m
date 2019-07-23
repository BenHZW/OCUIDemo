//
//  RootViewController.m
//  UI_8_1
//
//  Created by Ibokan_Teacher on 15/9/22.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    //记录表视图数据的数组
    NSArray *_names, *_numbers;
    
    //一个indexPath对象，记录单选选中的是哪一行
    NSIndexPath *_selectedIndexPath;
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
    
    //1.创建表视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 30, 270, 300) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    
    //2.设置代理
    tableView.dataSource = self;
    tableView.delegate = self;
    
    
    //3.给表视图注册要显示的单元格的类型以及对应的标识符
    //[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"students"];
    
    //3.ex.不注册单元格
    
    
    
    //4.通过某种途径获得数据源，并以某种形式记录下来
    _names = @[@"蔡恒诚", @"蔡梓锋", @"陈奕智", @"范凤涛", @"辜东明", @"郭展富", @"何福威", @"黄嘉龙", @"黄智文", @"邝健锋", @"李宇婷", @"林宇", @"苏文略", @"翁灿资", @"伍宏伟", @"于其亮", @"张振杰", @"钟保", @"邹耀成", @"肖梓浩", @"刘林强", @"罗杰", @"叶镇明", @"汤正礼", @"周少聪", @"郑伟超"];
    
    _numbers = @[@"A1", @"A2", @"A3", @"A4", @"A5", @"A6", @"A7", @"A8", @"A9", @"A10", @"B3", @"B4", @"B5", @"B6", @"B7", @"B8", @"B9", @"B10", @"B11", @"B12", @"B13", @"C1", @"C2", @"C3", @"C4", @"C5"];
    
    
    //5.如果要默认选中首个单元格
    _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}


#pragma mark - 表视图数据源的两个必须实现的代理方法
//返回表视图中每个分区分别有多少行
//有多少个分区，这个方法就会被调用多少次，每次传件来的参数section就是不同的分区号
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //本案例只有一个分区
    NSLog(@"number of rows in section: %ld", section);
    
    //返回对应分区有多少行
    return _names.count;
}

//返回每一行要显示的单元格
//整个表视图有多少行，这个方法就会被调用多少次
//同一行可能会重复调用这个方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //参数indexPath对象中存储着分区号和行号
    NSLog(@"分区号: %ld, 行号:%ld", indexPath.section, indexPath.row);
    
    //本案例只有一个分区，所以暂时先考虑行的问题即可
    
    
    //1.根据标识符获得需要的单元格
    //这个方法会根据提供的标识符，寻找是否有这样的单元格，如果有，就自动取出一个可以重用的单元格，如果没有则会自动创建一个新的
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"students" forIndexPath:indexPath];
    
    //1.ex.在没有注册单元格时
    //利用标识符尝试取出可以重用的单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"students"];
    //当单元格不存在时，就需要手动创建
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"students"];
    }
    
    
    
    
    //2.对这个单元格进行各种外观设置
    
    //设定显示的文本
    cell.textLabel.text = _names[indexPath.row];
    
    //设定细节文本
    cell.detailTextLabel.text = _numbers[indexPath.row];
    
    //设定要显示的图片
    NSString *imageName = [NSString stringWithFormat:@"img%02ld.png", indexPath.row + 1];
    UIImage *image = [UIImage imageNamed:imageName];
    cell.imageView.image = image;
    
    
    //3.实现单选效果
    //判断被选中的单元格的indexPath和当前的indexPath是否相等
    if ([_selectedIndexPath isEqual:indexPath])
    {
        //相等，勾上
        //用到单元格附件
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        //不相等，去勾
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    return cell;
    
    
}


#pragma mark - 表视图其他代理方法

//某个单元格已经被点击选中时调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select section:%ld, row:%ld", indexPath.section, indexPath.row);
    
    //记录原本选中的indexPath
    NSIndexPath *oldIndexPath = _selectedIndexPath;
    
    //记录新的被选中的单元格的indexPath
    _selectedIndexPath = indexPath;
    
    
    if (![oldIndexPath isEqual:_selectedIndexPath])
    {
        //立即刷新被选中的单元格
        [tableView reloadRowsAtIndexPaths:@[oldIndexPath, _selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        //让被勾选的单元格处于选中高亮状态
        [tableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    
    
    //取消选中，让单元格去掉高亮
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
