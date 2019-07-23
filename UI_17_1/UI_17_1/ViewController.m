//
//  ViewController.m
//  UI_17_1
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MyImageView.h"
#import "MyLabel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MyLabel *label;

@property (weak, nonatomic) IBOutlet MyImageView *_imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = @"我的";
    self._imageView.image = [UIImage imageNamed:@"abc.jpg"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
