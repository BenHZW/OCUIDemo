//
//  DrawView.m
//  UI_text
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DrawView.h"
@interface DrawView()
{
    CGFloat _previousValue;

}

@end
@implementation DrawView

-(void)awakeFromNib
{
    self.value = 0;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
       CGContextRef cr= UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(cr, 4);
    
    CGContextSetStrokeColorWithColor(cr, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(cr, [UIColor whiteColor].CGColor);
    
    CGContextBeginPath(cr);
    
    CGContextAddArc(cr, 100,100, 100, 2 * (1 - _value) * M_PI, 0 ,1);
    
//    CGContextAddArc(cr, 100,100, 100, 0, 2* M_PI ,1);
    
 CGContextDrawPath(cr, kCGPathFillStroke);
    
    

}



-(void)setValue:(CGFloat)value
{
    
    

   _value = value;
    
 [self setNeedsDisplay];

}
       




@end
