//
//  AdView.m
//  UI_4_2
//
//  Created by Ibokan_Teacher on 15/9/14.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "AdView.h"

@implementation AdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //初始化这个控件的其他事项
        
        //限制AdView的大小
        if ( CGRectGetWidth(frame) < 15 )
        {
            frame.size.width = 15;
        }
        
        
        if (CGRectGetHeight(frame) < 15 )
        {
            frame.size.height = 15;
        }
        
        //考虑到下面打算重写本类的setFrame方法，所以这里先用父类的setFrame
        super.frame = frame;
        
        
        
        //创建关闭按钮
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        
        CGPoint center;
        center.x = CGRectGetWidth(self.frame) - 5;
        center.y = CGRectGetHeight(self.frame) / 2;
        
        closeButton.center = center;
        
        [closeButton setTitle:@"X" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        //设置自动调整
        closeButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        [self addSubview:closeButton];
        
    }
    return self;
}


- (void)closeButtonPressed
{
    //从代理人处先获取应否关闭广告条
    
    BOOL shouldClose = YES;
    if ([self.delegate respondsToSelector:@selector(adViewShouldClose:)])
    {
        shouldClose = [self.delegate adViewShouldClose:self];
    }
    
    
    //判断决定是否应该关闭
    if (shouldClose)
    {
        //将自身隐藏起来
        self.hidden = YES;
        
        //执行关闭之后的代理方法
        if ([self.delegate respondsToSelector:@selector(adViewDidClose:)])
        {
            [self.delegate adViewDidClose:self];
        }
    }
}


#pragma mark - 重写setFrame方法
//防止设置不合理的frame
- (void)setFrame:(CGRect)frame
{
    if (CGRectGetHeight(frame) < 15 )
    {
        frame.size.height = 15;
    }
    
    if (CGRectGetWidth(frame) < 15 )
    {
        frame.size.width = 15;
    }
    
    //调用父类的方法
    [super setFrame:frame];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
