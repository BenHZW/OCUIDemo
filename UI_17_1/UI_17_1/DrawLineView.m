//
//  DrawLineView.m
//  UI_17_1
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //1.只有在本方法里才能获得系统提供的上下文
    CGContextRef cr = UIGraphicsGetCurrentContext();
    
  
    //2.画线
    
    //2.1.设置画笔属性
    CGContextSetLineWidth(cr, 4);
    
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(cr, [UIColor blueColor].CGColor);
    
    //设置虚线样式
    //需要一个CGFloat的数组,指明实、虚长度模式
    CGFloat dashes[] = {20 , 10 , 30 ,5};
    
    
        CGContextSetLineDash(cr,0, dashes, 4);
        
    
    //CGContextSetLineDash(cr,15, dashes, 4);
    
    
    //2.2.绘制点和路径
    
    //开始画线
    CGContextBeginPath(cr);
    
    //把画笔挪到一个点
    CGContextMoveToPoint(cr, 30, 30);
    
    //连线到下一个点
    CGContextAddLineToPoint(cr, 40, 200);
    
    
    //再连一个点
    CGContextAddLineToPoint(cr, 240, 50);
    
    //接着画一条弧线
    CGContextAddArcToPoint(cr, 190, 120, 80, 70, 120);
    
    //让一段路径闭合起来
    CGContextClosePath(cr);
    
    //把路径真正画出来
    //CGContextStrokePath(cr);
    
    //2.3.填充闭合路径
    //填充之前必须保证有一段闭合路径,但不用把路径画出来
    
    //设置填充颜色
    CGContextSetFillColorWithColor(cr, [UIColor redColor].CGColor);
    
    //真正的把颜色填充上去
   // CGContextFillPath(cr);

    //填充的同时也画路径
    CGContextDrawPath(cr, kCGPathFillStroke);
    
    
}


@end
