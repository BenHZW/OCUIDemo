//
//  ViewController.m
//  UI_14_Homework1
//
//  Created by Ibokan_Teacher on 15/10/21.
//  Copyright © 2015年 ios22. All rights reserved.
//

#import "ViewController.h"
#import "MyStepper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MyStepper *stepper;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //代码添加target
    /*
    [self.stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    */
    
}

#pragma mark - stepper值改变的响应方法
- (IBAction)stepperValueChanged:(MyStepper *)sender
{
    NSLog(@"在controller中得知stepper的值改变为: %f", sender.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
