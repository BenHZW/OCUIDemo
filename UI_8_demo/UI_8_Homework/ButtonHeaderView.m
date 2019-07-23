//
//  ButtonHeaderView.m
//  表视图折叠
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import "ButtonHeaderView.h"

@interface ButtonHeaderView ()
{
    //分区头视图上的按钮
    UIButton *_headerButton;
}
@end


@implementation ButtonHeaderView

#pragma mark - 重写便利初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //在这里添加按钮
        _headerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_headerButton];
        
        //设置按钮外观效果
        _headerButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _headerButton.backgroundColor = [UIColor yellowColor];
        _headerButton.titleLabel.font = [UIFont systemFontOfSize:30];
        _headerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //添加按钮响应方法
        [_headerButton addTarget:self action:@selector(headerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


#pragma mark - 点击按钮时
- (void)headerButtonPressed
{
    //调用代理方法(可选方法调用前应判断)
    if ([self.delegate respondsToSelector:@selector(buttonHeaderViewDidPress:)])
    {
        [self.delegate buttonHeaderViewDidPress:self];
    }
}

#pragma mark - 重写buttonTitle的setter、getter
- (void)setButtonTitle:(NSString *)buttonTitle
{
    //实际上就是设置_headerButton的文字
    [_headerButton setTitle:buttonTitle forState:UIControlStateNormal];
}

- (NSString *)buttonTitle
{
    //实际上就是获取_headerButton的文字
    return [_headerButton titleForState:UIControlStateNormal];
}



@end
