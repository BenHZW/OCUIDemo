//
//  ColorPalette.m
//  UI-4-Homework
//
//  Created by CJJMac on 15-5-12.
//  Copyright (c) 2015年 CJJMac. All rights reserved.
//

#import "ColorPalette.h"
#import "NSString+GetCharacter.h"


//限制frame的宽度不能小于200，高度不能小于120
#define WIDTH_MIN 180
#define HEIGT_MIN 120

//文本框和滑块tag值的起始值
#define TEXT_FIELD_TAG 100
#define SLIDER_TAG 110


#pragma mark - 可以在延展遵守协议
//这样在头文件就看不到这个类自身遵守了什么协议
@interface ColorPalette ()<UITextFieldDelegate>

@end



@implementation ColorPalette

- (id)initWithFrame:(CGRect)frame
{
    //限制frame的宽度、高度
    if (frame.size.width < WIDTH_MIN)
        frame.size.width = WIDTH_MIN;
    
    if (frame.size.height < HEIGT_MIN)
        frame.size.height = HEIGT_MIN;
    
    
    self = [super initWithFrame:frame];
    if (self)
    {
        //用一个循环初始化三个标签、三个文本框、三个滑块
        
        
        //用一个字符串存储@"RGB"三个字，下面有用
        NSString *RGBString = @"RGB";
        
        for (NSInteger i = 0; i < 3; ++i)
        {
            //获取自身frame的高度值（后面有用）
            CGFloat frameHeight = CGRectGetHeight(self.frame);
            
            
            
            //创建标签
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
            [self addSubview:label];
            
            //通过center属性，改变标签的位置
            CGPoint labelCenter = label.center;
            labelCenter.y = frameHeight / 4 * ( i + 1 );
            label.center = labelCenter;
            
            //按照下标，取出"R"、"G"、"B"
            label.text = [RGBString characterStringAtIndex:i];//这里重用了以前写的字符串类目方法
            
            //标签上下边距自适应
            label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            
            
            
            
            //创建文本框
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 5 + 40*i, 45, 30)];
            [self addSubview:textField];
            
            //通过center属性，改变文本框的位置
            CGPoint textFieldCenter = textField.center;
            textFieldCenter.y = frameHeight / 4 * ( i + 1 );
            textField.center = textFieldCenter;
            
            //设置边框、文本对齐方式、键盘样式等
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.text = @"0";
            
            textField.tag = TEXT_FIELD_TAG + i;//文本框的tag值：100~102
            
            //添加文本改变后响应方法
            [textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
            //设置文本框代理
            textField.delegate = self;
            
            //增加键盘回收键
            UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
            [returnButton setTitle:@"回收键盘" forState:UIControlStateNormal];
            returnButton.backgroundColor = [UIColor grayColor];
            [returnButton addTarget:textField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
            textField.inputAccessoryView = returnButton;
            
            //文本框上下边距自适应
            textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            
            
            
            
            //创建滑块
            CGFloat frameWidth = CGRectGetWidth(self.frame);
            
            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(90, 5 + 40 * i, frameWidth - 90 - 5, 30)];
            [self addSubview:slider];
            
            
            //通过center属性，改变标签的位置
            CGPoint sliderCenter = slider.center;
            sliderCenter.y = frameHeight / 4 * ( i + 1 );
            slider.center = sliderCenter;
            
            
            //设定滑块的取值范围为0~255
            slider.minimumValue = 0;
            slider.maximumValue = 255;
            
            //滑块滑动响应的方法
            [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
            
            slider.tag = SLIDER_TAG + i;//滑块的tag值：110~112
            
            //滑块上、下、左边距、宽度距自适应
            slider.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
            
        }
        
    }
    return self;
}

#pragma mark - 文本框文字改变后触发的方法
- (void)textFieldEditingChanged:(UITextField*)textField
{
    //根据textField的tag算出对应slider的tag
    NSInteger sliderTag = textField.tag + 10;
    
    //用根据tag值，获取对应的slider
    UISlider *slider = (UISlider*)[self viewWithTag:sliderTag];
    
    //改变slider的值
    slider.value = [textField.text integerValue];
    
    
    //执行代理的代理方法
    if( [self.delegate respondsToSelector:@selector(colorPaletteColorDidChange:)] )
        [self.delegate colorPaletteColorDidChange:self];
}


#pragma mark - 决定文本框文字能否改变的方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //拓展知识：用正则表达式判断输入的字符串是不是整数
    //下面 @"^\\d*$" 正则表达式字符串，表示要匹配“零个或多个数字”
    NSRange numberRange = [string rangeOfString:@"^\\d*$" options:NSRegularExpressionSearch];
    
    //如果输入的是数字，那么numberRange得到的应该是有效范围
    //如果输入的不是数字，那么numberRange得到的范围是NSNotFound，这时可以直接返回NO，表示不允许这次修改
    if ( numberRange.location == NSNotFound )
        return NO;
    
    
    //预测改变后的字符串是newString
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //不允许输入的数字大于255
    if ([newString integerValue] > 255 )
        return NO;
    else
        return YES;
}


#pragma mark - 滑块值改变后触发的方法
- (void)sliderValueChanged:(UISlider*)slider
{
    //根据slider的tag值计算出对应textField的值
    NSInteger textFieldTag = slider.tag - 10;
    
    //根据tag值取得对应的textField
    UITextField *textField = (UITextField*)[self viewWithTag:textFieldTag];
    
    //改变对应文本框的文本
    textField.text = [NSString stringWithFormat:@"%ld",(NSUInteger)slider.value];
    
    //执行代理的代理方法
    if( [self.delegate respondsToSelector:@selector(colorPaletteColorDidChange:)] )
        [self.delegate colorPaletteColorDidChange:self];
}


#pragma mark - 为限制frame的最小值，需重写setFrame方法
//这样在以后frame被修改时也起到限制效果
- (void)setFrame:(CGRect)frame
{
    //限制frame的宽度、高度
    if (frame.size.width < WIDTH_MIN)
        frame.size.width = WIDTH_MIN;
    
    if (frame.size.height < HEIGT_MIN)
        frame.size.height = HEIGT_MIN;
    
    //调用父类的setFrame方法
    [super setFrame:frame];
}


#pragma mark - 实现color属性的setter
- (void)setColor:(UIColor *)color
{
    //从color中解析出RGB值
    //这三个数值暂存于数组中
    CGFloat colorValues[3];
    
    [color getRed:&colorValues[0] green:&colorValues[1] blue:&colorValues[2] alpha:NULL];
    
    
    
    
    //设置滑块和文本框值
    for (NSInteger i = 0; i < 3; ++i)
    {
        //注意将0.0~1.0的值转换为0~255
        colorValues[i] *= 255;
        
        UITextField *textField = (UITextField*)[self viewWithTag:TEXT_FIELD_TAG + i];
        textField.text = [NSString stringWithFormat:@"%ld", (NSUInteger)colorValues[i]];
        
        
        UISlider *slider = (UISlider*)[self viewWithTag:SLIDER_TAG + i];
        slider.value = colorValues[i];
    }
}


#pragma mark - 实现color属性的getter
//通过它直接返回一个UIColor对象
- (UIColor *)color
{
    //根据tag值从取出三个slider的value，放入数组
    //这里不妨使用C语言数组
    float allSliderValues[3];
    
    for (NSInteger sliderTag = 110; sliderTag <= 112; ++sliderTag)
    {
        UISlider *aSlider = (UISlider*)[self viewWithTag:sliderTag];
        
        allSliderValues[sliderTag - 110] = aSlider.value / 255.0;
    }
    
    //取出数组中slider的value，用来创建一个UIColor
    return [UIColor colorWithRed:allSliderValues[0] green:allSliderValues[1] blue:allSliderValues[2] alpha:1];
}



@end
