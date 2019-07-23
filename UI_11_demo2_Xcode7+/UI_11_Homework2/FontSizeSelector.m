//
//  FontSizeSelector.m
//  备忘录
//
//  Created by CJJMac on 15-1-11.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import "FontSizeSelector.h"

#pragma mark - 字号选择器
@implementation FontSizeSelector

#define SIZE_BUTTON_HEIGHT 30
#define SIZE_BUTTON_WIDTH 50
#define SIZE_BUTTON_COUNT 5

- (id)initWithOrigin:(CGPoint)origin
{
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    //限定视图大小
    frame.size = CGSizeMake(SIZE_BUTTON_WIDTH, SIZE_BUTTON_HEIGHT * SIZE_BUTTON_COUNT - (SIZE_BUTTON_COUNT - 1));
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        //生成5个按钮
        for (NSInteger i = 0; i < SIZE_BUTTON_COUNT ; ++i)
        {
            UIButton *sizeButton = [UIButton buttonWithType:UIButtonTypeSystem];
            sizeButton.frame = CGRectMake(0, i * SIZE_BUTTON_HEIGHT - i, SIZE_BUTTON_WIDTH, SIZE_BUTTON_HEIGHT);
            [self addSubview:sizeButton];
            
            
            sizeButton.backgroundColor = [UIColor clearColor];
            [sizeButton setTitle:[NSString stringWithFormat:@"%ld", i + 1] forState:UIControlStateNormal];
            
            sizeButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
            sizeButton.layer.borderWidth = 1;
            
            [sizeButton addTarget:self action:@selector(fontSizeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [sizeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        //面板背景色
        self.backgroundColor = [UIColor whiteColor];
        
        //面板默认隐藏
        self.hidden = YES;
        
        //初始化弹出面板的按钮
        _showFontSizeSelectorButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"font_size_selector.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showSelectorButtonPressed)];
        _showFontSizeSelectorButton.tintColor = [UIColor blackColor];
        
    }
    
    return self;
}

#pragma mark - 点击字体选择按钮
- (void)fontSizeButtonPressed:(UIButton*)button
{
    self.hidden = YES;
    
    [self.delegate fontSizeSelector:self selectedSize:button.titleLabel.text.integerValue];
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
