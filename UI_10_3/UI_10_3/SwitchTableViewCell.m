//
//  SwitchTableViewCell.m
//  UI_8_3
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "SwitchTableViewCell.h"
#import "TextSwitch.h"

@implementation SwitchTableViewCell


- (IBAction)switchValueChanged:(UISwitch*)aSwitch
{
    //开关状态改变后，模型的值要跟着改
    self.textSwitch.on = aSwitch.isOn;
}


//重写模型的setter
- (void)setTextSwitch:(TextSwitch *)textSwitch
{
    //当模型被重新设置后，文本、开关状态也要跟随改变
    _textSwitch = textSwitch;
    
    self.textLabel.text = _textSwitch.text;
    self.theSwitch.on = _textSwitch.isOn;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
