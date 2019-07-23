//
//  SplitViewController.m
//  New UI
//
//  Created by apple on 15/11/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SplitViewController.h"
#import "SplitViewControllerDelegate.h"
@interface SplitViewController ()

@property(nonatomic, strong)SplitViewControllerDelegate *strongDelegateReference;
@end

@implementation SplitViewController

-(void)awakeFromNib
{
    self.value = 2;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.strongDelegateReference = [SplitViewControllerDelegate new];
    
    self.delegate = self.strongDelegateReference;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
