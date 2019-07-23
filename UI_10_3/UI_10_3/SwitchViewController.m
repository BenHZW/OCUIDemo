//
//  SwitchViewController.m
//  UI_10_3
//
//  Created by Ibokan_Teacher on 15/9/29.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SwitchViewController.h"

@interface SwitchViewController ()
{
    __weak IBOutlet UILabel *_titileLabel;
    __weak IBOutlet UISwitch *_theSwitch;
}
@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //根据传入的模型，设置开关状态
    _theSwitch.on = self.textSwitch.isOn;
    
    //模拟点击开关，起到设置标签文字的效果
    [self switchValueChanged:_theSwitch];
    
    //设置标题
    self.title = self.textSwitch.text;
    
    
}


#pragma mark - 导航栏开关响应方法
- (IBAction)switchValueChanged:(UISwitch *)sender
{
    BOOL switchIsOn = sender.isOn;
    
    //改变标签文字
    _titileLabel.text = switchIsOn ? @"开" : @"关";
    
    //改变模型开关值
    _textSwitch.on = switchIsOn;
    
    
    //调用代理方法
    if ([self.delegate respondsToSelector:@selector(switchViewController:)])
    {
        [self.delegate switchViewController:self];
    }
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
