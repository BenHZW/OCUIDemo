//
//  TextSwitch.m
//  UI_8_3
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "TextSwitch.h"

@implementation TextSwitch

+ (instancetype)textSwitchWithString:(NSString *)string isOnState:(BOOL)state
{
    TextSwitch *ts = [self new];
    ts.text = string;
    ts.on = state;
    
    return ts;
}



@end





