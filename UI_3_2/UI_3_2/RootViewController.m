//
//  RootViewController.m
//  UI_3_2
//
//  Created by Ibokan_Teacher on 15/9/11.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

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
    
    //1.滑块
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(20, 50, 200, 70)];
    [self.view addSubview:slider1];
    
    
    slider1.maximumValue = 100;
    
    slider1.value = 40;
    
    slider1.minimumTrackTintColor = [UIColor redColor];
    
    slider1.thumbTintColor = [UIColor blueColor];
    
    
    //添加滑块拖动时响应的方法
    [slider1 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    //2.步进器
    UIStepper *stepper1 = [[UIStepper alloc] initWithFrame:CGRectMake(20, 150, 0, 0)];
    [self.view addSubview:stepper1];
    
    //设置最大最小值、步进值
    //设置/获取当前值
    //添加响应方法
    //留个大家尝试
    
    
    //3.分段控制器
    //分段控制器上有多个分段，每一段上面有文字或图片，可以用含有字符串或图片的数组进行初始化
    UISegmentedControl *segmentedControl1 = [[UISegmentedControl alloc] initWithItems:@[@"s1", @"s2", @"s3"]];
    [self.view addSubview:segmentedControl1];
    
    
    segmentedControl1.frame = CGRectMake(200, 150, 100, 50);
    
    //作用是：
    //segmentedControl1.momentary = YES;
    
    //设置选中的段
    segmentedControl1.selectedSegmentIndex = 2;
    
    //设置某一段的宽度
    [segmentedControl1 setWidth:20 forSegmentAtIndex:1];
    
    
    //添加点击不同分段响应的方法
    [segmentedControl1 addTarget:self action:@selector(selectedSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    //4.开关
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(70, 250, 0, 0)];
    [self.view addSubview:aSwitch];
    
    aSwitch.on = YES;
    
    //添加开关值变化时的响应方法
    //留给大家尝试
    
}


#pragma mark - 滑块拖动时触发的方法
- (void)sliderValueChanged:(UISlider*)slider
{
    NSLog(@"slider.value: %f", slider.value);
}


#pragma mark - 分段控制器选中段改变触发的方法
- (void)selectedSegmentChanged:(UISegmentedControl*)segmentedControl
{
    //打印选中分段上的文字
    NSUInteger index = segmentedControl.selectedSegmentIndex;
    
    NSString *title = [segmentedControl titleForSegmentAtIndex:index];
    
    NSLog(@"selected: %@", title);
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
