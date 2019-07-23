//
//  MyView.m
//  TouchText
//
//  Created by Gemll on 16/2/14.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__begin");
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__finish");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__end");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__move");
}

@end
