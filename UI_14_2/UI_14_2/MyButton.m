//
//  MyButton.m
//  UI_14_2
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyButton.h"
@interface MyButton()
{
    
    
    //是否开始触摸时在控件内部
    BOOL _isTouchBeganInside;
    
    

}
@end


@implementation MyButton

#pragma mark - 为了实现TouchUpInside事件，重写触摸事件的方法

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 /*
  //touches集合里面存放的是UITouch对象
    //有多少个手指触摸就有多少个元素
    //event包含这些触摸事件的更多信息
    
    //1.假设规定触摸的手指只有一个
    //则touches集合中只有一个元素，把它取出来
   UITouch *aTouch = [touches anyObject];
    
   //2.求出触摸点是否在这个控件内
    CGPoint beginTouchPointInSelf = [aTouch locationInView:self];
  _isTouchBeganInside =  CGRectContainsPoint(self.bounds, beginTouchPointInSelf);
    
    */
    
    
        
        UITouch *touch1  = [touches anyObject];
        
    NSLog(@"%f",touch1.force);
        }
        
        
        
    

    






-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   //用相同的方式检查触摸结束时点是否在控件内
    UITouch *aTouch = [touches anyObject];
    
    CGPoint endTouchPointInself = [aTouch locationInView:self];
    
    BOOL isTouchEndedInside = CGRectContainsPoint(self.bounds, endTouchPointInself);
    
    //只有开始和结束的触摸点都在本控件内，才是TouchUpInside
    if(_isTouchBeganInside && isTouchEndedInside)
    {
    
        NSLog(@"识别出TouchUpInside事件");
        
        //发送TouchUpInside事件通知
        //使得target能响应这个事件
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        
      
    }
    
    
    
 

}



@end
