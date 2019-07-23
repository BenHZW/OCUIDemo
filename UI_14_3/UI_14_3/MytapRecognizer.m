//
//  MytapRecognizer.m
//  UI_14_3
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//
//自定义手势识别器，其实就是将关于手势事件的方法封装成一个模型
#import "MytapRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface MytapRecognizer()
{
    //记录开始点击的点
    CGPoint _touchBeginPoint;
    //记录开始点击的时间的戳
    NSTimeInterval _touchBeginTimestamp;
    

}

@end

@implementation MytapRecognizer

//实现关于触摸事件的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"开始点击");
    
    UITouch *aTouch = [touches anyObject];
    
    _touchBeginPoint = [aTouch locationInView:aTouch.view];
   //设置对应手势状态，这样taget才会有响应
    
    self.state = UIGestureRecognizerStateBegan;
    
    _touchBeginTimestamp = aTouch.timestamp;
   
    //设置对应的手势状态,这样target才会有响应
    self.state = UIGestureRecognizerStateBegan;
    
    

}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"点击结束");
    UITouch *aTouch = [touches anyObject];

    CGPoint touchEndPoint = [aTouch locationInView:aTouch.view];
    
    NSTimeInterval touchEndTimeStamp = aTouch.timestamp;
    //计算两点距离
    double distanceSquare = pow((_touchBeginPoint.x - touchEndPoint.x) , 2)+pow(_touchBeginPoint.y - touchEndPoint.y ,2 );
    
    
    NSTimeInterval deltaTime = touchEndTimeStamp - _touchBeginTimestamp;
    //根据自己设计判断手势识别结果
    if (distanceSquare < 25 && deltaTime < 0.5  ) {
        
        //识别成功
        self.state = UIGestureRecognizerStateEnded;
        
    }
    else{
        //识别失败，设置失败状态
    }
    
}





@end




