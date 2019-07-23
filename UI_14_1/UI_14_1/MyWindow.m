//
//  MyWindow.m
//  UI_14_1
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow

#pragma mark - 重写触摸事件方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"My window touches began");
    [self.nextResponder touchesBegan:touches withEvent:event];

}



@end
