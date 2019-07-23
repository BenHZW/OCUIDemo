//
//  BlockTransferViewController.h
//  UI_7
//
//  Created by Ibokan_Teacher on 15/9/21.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ValueTransferViewController.h"

//代码块传值实验
@interface BlockTransferViewController : ValueTransferViewController

//用于传值的代码块
@property(nonatomic, copy)void(^transferBlock)(BlockTransferViewController*);

@end







