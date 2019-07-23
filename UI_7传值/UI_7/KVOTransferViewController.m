//
//  KVOTransferViewController.m
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "KVOTransferViewController.h"

NSString *const KVOTransferViewControllerTextChangedKey = @"textField.text";


@interface KVOTransferViewController ()

@end

@implementation KVOTransferViewController

#pragma mark - 添加观察者的便利初始化方法
- (id)initWithObserver:(id)observer
{
    self = [super init];
    if (self)
    {
        //添加观察者
        _observer = observer;
        
        [self addObserver:_observer forKeyPath:KVOTransferViewControllerTextChangedKey options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


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
    self.title = @"KVO传值";
}

- (void)dealloc
{
    //移除KVO观察者
    if (_observer != nil)
    {
        [self removeObserver:_observer forKeyPath:KVOTransferViewControllerTextChangedKey];
    }
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
