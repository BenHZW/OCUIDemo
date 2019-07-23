//
//  MyStepper.m
//  UI-15-Homework1
//
//  Created by CJJMac on 15-6-4.
//  Copyright (c) 2015年 CJJMac. All rights reserved.
//

#import "MyStepper.h"

@interface MyStepper ()
{
    //在控件上放置+、-两个标签
    //标签不会响应用户交互
    UILabel *_plusLabel, *_minusLabel;
}
@end


@implementation MyStepper
#pragma mark - 此方法仅在使用xib或storyboard时有效
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initIssues];
}

#pragma mark - 此方法仅在使用initWithFrame初始化时有效
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initIssues];
    }
    return self;
}


#pragma mark - 初始化本控件的各个细节
- (void)initIssues
{
    //设置4个变量默认值
    _value = 0;
    
    _minimumValue = 0;
    
    _maximumValue = 100;
    
    _stepValue = 1;
    
    
    //初始化+、-两个标签
    //两个标签宽度为Stepper宽度的一半，分居左右
    //两个标签高度与Stepper相同
    
    CGFloat labelWidth = CGRectGetWidth(self.frame) / 2;
    CGFloat labelHeight = CGRectGetHeight(self.frame);
    
    
    _plusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelHeight)];
    
    _plusLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;//尺寸自适应
    
    _plusLabel.text = @"+";
    
    _plusLabel.textAlignment = NSTextAlignmentCenter;//文字居中对齐
    
    //设置边框颜色
    _plusLabel.layer.borderColor = [UIColor blackColor].CGColor;
    
    //设置边框宽度
    _plusLabel.layer.borderWidth = 2;
    
    [self addSubview:_plusLabel];
    
    
    
    
    _minusLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 0, labelWidth, labelHeight)];
    
    _minusLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;//尺寸自适应
    
    _minusLabel.text = @"-";
    
    _minusLabel.textAlignment = NSTextAlignmentCenter;//文字居中对齐
    
    //设置边框颜色
    _minusLabel.layer.borderColor = [UIColor blackColor].CGColor;
    
    //设置边框宽度
    _minusLabel.layer.borderWidth = 2;
    
    [self addSubview:_minusLabel];
    
    
    //设置不允许多点触控
    self.multipleTouchEnabled = NO;
}


#pragma mark - 四个属性均有取值限制，需要重写对应的setter

#pragma mark - 设置当前值
- (void)setValue:(double)value
{
    //逻辑：必须在最大值与最小值之间
    if( value >= self.minimumValue && value <= self.maximumValue )
    {
        _value = value;
    }
}

#pragma mark - 设置最小值
- (void)setMinimumValue:(double)minimumValue
{
    //逻辑：必须小于最大值
    if (minimumValue < self.maximumValue)
    {
        _minimumValue = minimumValue;
    }
}

#pragma mark - 设置最大值
- (void)setMaximumValue:(double)maximumValue
{
    //逻辑：必须大于最小值
    if (maximumValue > self.minimumValue)
    {
        _maximumValue = maximumValue;
    }
}

#pragma mark - 设置步进值
- (void)setStepValue:(double)stepValue
{
    //逻辑：必须大于0
    if (stepValue > 0)
    {
        _stepValue = stepValue;
    }
}







#pragma mark - 重点在这里

//只需检测“开始点击”的时候，手指点在了哪个标签的范围
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //0.记录value原来的值
    double previousValue = self.value;
    
    
    //1.取出触摸点
    UITouch *aTouch = [touches anyObject];
    
    //2.检测触摸点位置（以本控件为参照）
    CGPoint touchPoint = [aTouch locationInView:self];
    
    //2.1.如果触摸点在“+”标签内
    if (CGRectContainsPoint(_plusLabel.frame, touchPoint))
    {
        //增加步进值
        self.value += self.stepValue;
    }
    
    //2.2.否则就是在“-”标签内了
    else
    {
        //减去步进值
        self.value -= self.stepValue;
    }
    
    
    //3.将新的value值与原来的value值比较
    //两者不相等，才发送ValueChanged消息
    if( self.value != previousValue )
    {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}




@end
