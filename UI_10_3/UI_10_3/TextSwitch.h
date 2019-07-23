//
//  TextSwitch.h
//  UI_8_3
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextSwitch : NSObject

//两个属性，记录文本和开关状态
@property(nonatomic, copy)NSString *text;
@property(nonatomic, getter = isOn)BOOL on;

//便利构造器
+ (instancetype)textSwitchWithString:(NSString*)string isOnState:(BOOL)state;

@end










