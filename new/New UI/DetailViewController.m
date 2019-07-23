//
//  DetailViewController.m
//  Touch3DTableView
//
//  Created by CJJMac on 15/11/20.
//  Copyright © 2015年 CJJMac. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.myImageView.image = self.transformImage;
    
    
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"退出" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"已执行");
    }];
    
    return @[action1];
}
//单击退出
- (IBAction)tapAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
