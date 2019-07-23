//
//  AViewController.m
//  HuangzhiwenPageViewControllerDemo
//
//  Created by Gemll on 16/2/19.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "AViewController.h"
#import "MyViewController.h"
@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor greenColor];
    NSLog(@"到达A");
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 300, 300)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push
{
    MyViewController *myViewController = [[MyViewController alloc] init];
    [self.navigationController pushViewController:myViewController animated:YES ];
    myViewController.backTo = ^(NSString *str1)
    {
        NSLog(@"---%@",str1);
    
    };
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
