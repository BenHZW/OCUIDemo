//
//  KVOTransferViewController.h
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ValueTransferViewController.h"

@interface KVOTransferViewController : ValueTransferViewController

//记录观察自己的观察者是谁
@property(nonatomic, readonly, assign)id observer;


//便利初始化方法
- (id)initWithObserver:(id)observer;


//要被观察的键值路径
extern NSString *const KVOTransferViewControllerTextChangedKey;


@end







