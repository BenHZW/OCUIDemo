//
//  NoteListController.m
//  备忘录
//
//  Created by CJJMac on 15-1-3.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import "NoteListController.h"
#import "NoteListCellContent.h"


@interface NoteListController ()

{
    //记录笔记列表的数组
    NSMutableArray *_noteList;
    
    //一个全局变量记录当前编辑的已有记录
    NoteListCellContent *_nowEditingContent;
    
    //全局变量记录要删除的行
    NSIndexPath *_rowIndexPathToDelete;
}

@end

@implementation NoteListController

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
    
    //读取从数据源（备忘录列表）
    [self readNoteListFromFile];
    
}



#pragma mark

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //每当视图消失（看不见），取消编辑状态
    self.tableView.editing = NO;
    
}


#pragma mark - 删除按钮操作
- (IBAction)removeButtonPressed
{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

- (void)addButtonPressed
{
    TextEditingController *textEditingController = [TextEditingController new];
    
    textEditingController.delegate = self;
    
    [self.navigationController pushViewController:textEditingController animated:YES];
}



#pragma mark - 定义某一条备忘录对应的文件名
#define NoteFileNameFromDateString( dateString ) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:dateString]


#pragma mark - 读写列表文件
//定义列表文件的文件名
#define NoteListFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"note_list"]

- (void)readNoteListFromFile
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //获取列表文件的文件名
    NSString *noteListFileName = NoteListFileName;
    
    NSLog(@"noteList\n%@", noteListFileName);
    
    //如果文件不存在则创建
    if (![manager fileExistsAtPath:noteListFileName])
    {
        _noteList = [NSMutableArray new];
        
        [self writeNoteListToFile];
    }
    else
    {   //如果文件存在就可以读取了
        
        _noteList = [NSKeyedUnarchiver unarchiveObjectWithFile:noteListFileName];
    }
    
}

- (void)writeNoteListToFile
{
    [NSKeyedArchiver archiveRootObject:_noteList toFile:NoteListFileName];
}



#pragma mark - 根据当前日期时间生成字符串
- (NSString*)getCurrentDateString
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFomatter = [NSDateFormatter new];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH_mm_ss";
    dateFomatter.timeZone = [NSTimeZone systemTimeZone];
    
    return [dateFomatter stringFromDate:now];
}



#pragma mark - 表视图数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _noteList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"note";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    //把备忘录摘要和日期显示在单元格上
    NoteListCellContent *content = _noteList[indexPath.row];
    
    cell.textLabel.text = content.abstract;
    cell.detailTextLabel.text = content.dateString;
    
    return cell;
}

/*
#pragma mark - 点击表视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //记录当前编辑的备忘录
    _nowEditingContent = _noteList[indexPath.row];
    
    
    //读取对应的备忘录文件
    NSAttributedString *attrText = [NSKeyedUnarchiver unarchiveObjectWithFile: NoteFileNameFromDateString(_nowEditingContent.dateString)];
    
    
    //在文本编辑器中打开
    TextEditingController *textEditingController = [TextEditingController new];
    textEditingController.textFileName = _nowEditingContent.dateString;
    
    textEditingController.attrText = attrText;
    
    //要设置代理
    textEditingController.delegate = self;
    
    
    
    [self.navigationController pushViewController:textEditingController animated:YES];
    
}
 */



#pragma mark - 编辑表视图
//主要是删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除备忘录操作
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //1.先删除对应的数据源
        NoteListCellContent *contentToBeDelete = _noteList[indexPath.row];
        
        //1.1.从数组中删除
        [_noteList removeObjectAtIndex:indexPath.row];
        //更新数组文件
        [self writeNoteListToFile];
        
        //1.2.删除对应的备忘录文件
        NSString *notePath = NoteFileNameFromDateString(contentToBeDelete.dateString);
        [[NSFileManager defaultManager] removeItemAtPath:notePath error:nil];
        
        
        
        //2.删除单元格
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - 文本编辑器代理方法
- (void)textEditingControllerDidSaveEditing:(TextEditingController *)textEditingController
{
    //检查是不是新文件
    if (textEditingController.textFileName == nil)//是新文件，才还没有文件名
    {
        //以当前时间作为文件名
        NSString *fileName_dateString = [self getCurrentDateString];
        
        
        [NSKeyedArchiver archiveRootObject:textEditingController.attrText toFile:NoteFileNameFromDateString(fileName_dateString)];
        
        
        //创建单元格摘要对象，并加入列表数组
        NoteListCellContent *content = [NoteListCellContent new];
        content.dateString = fileName_dateString;
        
        NSString *text = [textEditingController.attrText string];
        
        if (text.length > 60)
            content.abstract = [[text substringToIndex:59] stringByAppendingString:@"..."];
        else
            content.abstract = text;
        
        [_noteList addObject:content];
        
        
        
        
        //刷新表视图
        [self.tableView reloadData];
    }
    else
        //即已存在的文件
    {
        //覆盖原有文件

        [NSKeyedArchiver archiveRootObject:textEditingController.attrText toFile:NoteFileNameFromDateString( textEditingController.textFileName)];
        
        
        //更新表视图数据源
        NSString *text = [textEditingController.attrText string];
        if (text.length > 60)
            _nowEditingContent.abstract = [[text substringToIndex:59] stringByAppendingString:@"..."];
        else
            _nowEditingContent.abstract = text;
        

        
        //刷新表视图
        [self.tableView reloadData];

    }
    
    
    [self writeNoteListToFile];
    
    
    //最后弹出文本控制器
    [textEditingController.navigationController popViewControllerAnimated:YES];
    
}

- (void)textEditingControllerDidCancelEditing:(TextEditingController *)textEditingController
{
    //弹出文本控制器
    [textEditingController.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 跳转视图时传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //获取目标视图控制器
    TextEditingController *textEditingController = segue.destinationViewController;
    
    //设置代理
    textEditingController.delegate = self;
    
    
    
    
    //如果是点击单元格后传值的，则是要编辑原有记录，所以要增加以下步骤
    
    //记录当前编辑的备忘录
    if( [segue.identifier isEqualToString:@"cellDidSelect"] )
    {
        //则sender应该是单元格
        UITableViewCell *selectedCell = sender;
        
        //获取单元格对应的indexPath
        NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
        
        
        //记录当前要修改的记录
        _nowEditingContent = _noteList[indexPath.row];
        
        
        //在文本编辑器中打开（传入备忘录文件名）
        textEditingController.textFileName = _nowEditingContent.dateString;
        
        
        //读取对应的备忘录文件数据（富文本）
        NSAttributedString *attrText = [NSKeyedUnarchiver unarchiveObjectWithFile: NoteFileNameFromDateString(_nowEditingContent.dateString)];
        textEditingController.attrText = attrText;
    }
}


@end
