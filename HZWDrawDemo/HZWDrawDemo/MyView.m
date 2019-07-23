//
//  MyView.m
//  HZWDrawDemo
//
//  Created by Gemll on 16/1/26.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "MyView.h"
@interface MyView()
{
    //某一次划线的行为构成的坐标
    NSMutableArray *_points;
    //总共划线行为构成的坐标
    NSArray *_points_all;
    
    //画笔颜色
    UIColor *_paint_color;
    //上下文
    CGContextRef _context;
}

@end

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _paint_color = [UIColor blackColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //判断转折点数
    if ((!_points) || (_points.count < 2))
    {
        return;
    }
    //联系上下文
    _context = UIGraphicsGetCurrentContext();
    
    //设置画笔属性
    CGContextSetLineWidth(_context, 5.0f);
    CGContextSetStrokeColorWithColor(_context, [_paint_color CGColor]);
    
    //之前画出轨迹
    for (int j = 0; j < _points_all.count; j++)
    {
        NSMutableArray *points_temp = [_points_all objectAtIndex:j];
        for (int i = 0;                                i < points_temp.count - 1; i++)
        {
            //两点连线
            CGPoint point1 = [[points_temp objectAtIndex:i] CGPointValue];
            CGPoint point2 = [[points_temp objectAtIndex:(i+1)]CGPointValue];
            CGContextMoveToPoint(_context, point1.x, point1.y);
            CGContextAddLineToPoint(_context, point2.x, point2.y);
            CGContextStrokePath(_context);
        }
        
    }
    
    //这次画出来的轨迹
    for (int i = 0; i < _points.count - 1; i++)
    {
        //两点形成一线
        CGPoint point1 = [[_points objectAtIndex:i]CGPointValue];
        CGPoint point2 = [[_points objectAtIndex:i + 1] CGPointValue];
        CGContextMoveToPoint(_context, point1.x, point1.y);
        CGContextAddLineToPoint(_context, point2.x, point2.y);
        CGContextStrokePath(_context);
    }
    
}

//不支持多点触碰
- (BOOL)isMultipleTouchEnabled
{
    return NO;
}

//创建一个mutablearray,并且记录初始point
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _points = [NSMutableArray array];
    CGPoint point = [[touches anyObject] locationInView:self];
    [_points addObject:[NSValue valueWithCGPoint:point]];
}

//移动过程
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point1 = [[touches anyObject]locationInView:self];
    [_points addObject:[NSValue valueWithCGPoint:point1]];
    [self setNeedsDisplay];
}

//移动停止
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *points_temp = [[NSMutableArray alloc] initWithArray:_points];
    if (_points_all ==nil)
    {
        _points_all = [[NSArray alloc] initWithObjects:points_temp, nil];
    }
    else
    {
        _points_all = [_points_all arrayByAddingObject:points_temp];
    
    }


}

@end
