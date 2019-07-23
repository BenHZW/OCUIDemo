//
//  SwitchTableViewCell.h
//  UI_8_3
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextSwitch;

@interface SwitchTableViewCell : UITableViewCell

@property(nonatomic, weak)IBOutlet UISwitch *theSwitch;

//添加一个模型属性
@property(nonatomic, retain)TextSwitch *textSwitch;

@end






