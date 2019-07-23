//
//  RootViewController.m
//  UI-4-Homework
//
//  Created by CJJMac on 15-5-13.
//  Copyright (c) 2015年 CJJMac. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()
{
    //颜色方块，这个方块与调色板没有任何从属关系
    UIView *_colorView;
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
    
    //创建调色板
    ColorPalette *cp = [[ColorPalette alloc] initWithFrame:CGRectMake(20, 20,250, 0)];
    [self.view addSubview:cp];
    cp.delegate = self;
    
    
    //创建色块
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(270, 20, 40, 130)];
    [self.view addSubview:_colorView];
}

#pragma mark - 调色板代理方法
- (void)colorPaletteColorDidChange:(ColorPalette *)colorPalette
{
    _colorView.backgroundColor = colorPalette.color;
}



@end
