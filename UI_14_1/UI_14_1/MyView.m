//
//  MyView.m
//  UI_14_1
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyView.h"

@implementation MyView


#pragma mark -重写触摸事件的4个方法

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touches began",self.name);
  
    //如果本响应者能够自行处理触摸事件，则自己完成处理即可
    
    //如果想要把这个事件传递给下一个响应者处理，则要调用:
    [self.nextResponder touchesBegan:touches withEvent:event];
    
    //如果自身处理完这个事件后还要保留父类的处理方式，则要调用：
   // [super touchesBegan:touches withEvent:event];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
    NSLog(@"%@ touches ended",self.name);

    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ touches moved",self.name);
 
}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

     NSLog(@"%@ touches cancelled",self.name);

}


@end
