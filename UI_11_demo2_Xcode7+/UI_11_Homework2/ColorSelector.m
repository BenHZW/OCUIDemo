//
//  ColorSelector.m
//  备忘录
//
//  Created by CJJMac on 15-1-11.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import "ColorSelector.h"

#pragma mark - 颜色选择器
@implementation ColorSelector

#define COLOR_BUTTON_HEIGHT 30
#define COLOR_BUTTON_WIDTH 65
#define COLOR_BUTTON_COUNT 5

- (id)initWithOrigin:(CGPoint)origin
{
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    //限定视图大小
    frame.size = CGSizeMake(COLOR_BUTTON_WIDTH, COLOR_BUTTON_HEIGHT * COLOR_BUTTON_COUNT - (COLOR_BUTTON_COUNT - 1));
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        NSArray *colors = @[[UIColor blackColor],
                            [UIColor redColor],
                            [UIColor colorWithRed:254/255.0 green:175/255.0 blue:8/255.0 alpha:1], //深黄色
                            [UIColor blueColor],
                            [UIColor colorWithRed:0/255.0 green:90/255.0 blue:20/255.0 alpha:1] //深绿色
                            ];
        
        //生成个按钮
        for (NSInteger i = 0; i < COLOR_BUTTON_COUNT ; ++i)
        {
            UIButton *colorButton = [UIButton buttonWithType:UIButtonTypeSystem];
            colorButton.frame = CGRectMake(0, i * COLOR_BUTTON_HEIGHT - i, COLOR_BUTTON_WIDTH, COLOR_BUTTON_HEIGHT);
            [self addSubview:colorButton];
            
            
            colorButton.backgroundColor = colors[i];
            
            colorButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
            colorButton.layer.borderWidth = 1;
            
            [colorButton addTarget:self action:@selector(colorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        //面板默认隐藏
        self.hidden = YES;
        
        //初始化弹出面板的按钮
        UIButton *showSelectorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [showSelectorButton setImage:[UIImage imageNamed:@"color_selector.png"] forState:UIControlStateNormal];
        [showSelectorButton addTarget:self action:@selector(showSelectorButtonPressed)forControlEvents:UIControlEventTouchUpInside];
        
        _showColorSelectorButton = [[UIBarButtonItem alloc] initWithCustomView:showSelectorButton];
        
    }
    
    return self;
}

#pragma mark - 点击颜色选择按钮
- (void)colorButtonPressed:(UIButton*)button
{
    self.hidden = YES;
    
    [self.delegate colorSelector:self selectedColor:button.backgroundColor];
}

#pragma mark - 重写setFrame方法
- (void)setFrame:(CGRect)frame
{
    frame.size = self.frame.size;
    
    super.frame = frame;
}

#pragma mark - 点击弹出面板的按钮
- (void)showSelectorButtonPressed
{
    [self becomeFirstResponder];
    
    self.hidden = !self.hidden;
}
@end

