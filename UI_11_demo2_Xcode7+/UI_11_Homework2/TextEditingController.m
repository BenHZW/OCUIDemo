//
//  TextEditingController.m
//  备忘录
//
//  Created by Ibokan on 14-12-30.
//  Copyright (c) 2014年 fghf. All rights reserved.
//

#import "TextEditingController.h"
#import "UITextView+SetAttributedTextAttribute.h"

@interface TextEditingController ()
{
    __weak IBOutlet UITextView *_textEditingView;
    
    NSAttributedString *_attrText;
    
    
    //文本框底部约束
    __weak IBOutlet NSLayoutConstraint *_textEditingViewButtomConstraint;
}
@end

@implementation TextEditingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.处理多行文本框
    [self initTextView];
    
    //2.载入字号选择器和颜色选择器
    [self initFontSizeSelectorAndColorSelector];
    

}

#pragma mark - 文本框的键盘处理
- (void)initTextView
{
    
    //增加键盘返回按钮
    UIButton *keyBoardReturnButton = [UIButton buttonWithType:UIButtonTypeSystem];
    keyBoardReturnButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 20);
    
    [keyBoardReturnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [keyBoardReturnButton setTitle:@"︾" forState:UIControlStateNormal];
    keyBoardReturnButton.titleLabel.font = [UIFont systemFontOfSize:25];
    
    keyBoardReturnButton.backgroundColor = [UIColor grayColor];
    
    [keyBoardReturnButton addTarget:_textEditingView action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    
    
    _textEditingView.inputAccessoryView = keyBoardReturnButton;
    
    //从实例变量载入文字
    _textEditingView.attributedText = _attrText;
    
    
    
    //监听键盘frame改变的通知
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}

- (void)keyboardDidChangeFrame:(NSNotification*)notification
{
    NSLog(@"tongzho:%@", notification.userInfo);
    
    //通知中的“正文”信息字典
    NSDictionary *userInfo = notification.userInfo;
    
    //键盘变化前的frame
    CGRect keyboardFrameBegin = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    //键盘变化后的frame
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //变化前后的y轴差值
    CGFloat deltaY = CGRectGetMinY(keyboardFrameEnd) - CGRectGetMinY(keyboardFrameBegin);
    
    
    //文本框底部约束的常数值应该减去这个差值，实现文本框跟随键盘伸缩
    _textEditingViewButtomConstraint.constant -= deltaY;
    
}

#pragma mark - 撤销、重做按钮

- (IBAction)undoButtonPressed:(UIBarButtonItem*)sender
{
    [_textEditingView.undoManager undo];
}

- (IBAction)redoButtonPressed:(UIBarButtonItem*)sender
{
    [_textEditingView.undoManager redo];
}


#pragma mark - 载入字号选择器和颜色选择器
- (void)initFontSizeSelectorAndColorSelector
{
    FontSizeSelector *fontSizeSelector = [[FontSizeSelector alloc] initWithOrigin:CGPointMake(106, 0)];
    [self.view addSubview:fontSizeSelector];
    fontSizeSelector.delegate = self;
    
    
    
    
    ColorSelector *colorSelector = [[ColorSelector alloc] initWithOrigin:CGPointMake(155, 0)];
    [self.view addSubview:colorSelector];
    colorSelector.delegate = self;
    
    //按钮设计在字号选择器和颜色选择器中，只能用代码添加
    //把按钮添加到导航栏
    NSMutableArray *leftItems = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [leftItems addObjectsFromArray:@[fontSizeSelector.showFontSizeSelectorButton, colorSelector.showColorSelectorButton]];
    self.navigationItem.leftBarButtonItems = leftItems;

}

#pragma mark - 实现字号选择器和颜色选择器代理方法
- (void)fontSizeSelector:(FontSizeSelector *)fontSizeSelector selectedSize:(NSUInteger)size
{
    //文本被选中的范围
    //这个变量仅仅在记录撤销操作步骤时使用
    NSRange selectedRange = _textEditingView.selectedRange;
    
    
    if(selectedRange.length > 0)
    {
        
        //新字号
        UIFont *newFontSize = [UIFont systemFontOfSize:14 + (size - 1) * 5];

     
        //利用替换法，更新字号
        NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:[_textEditingView.attributedText attributedSubstringFromRange:selectedRange]];
        [newString addAttribute:NSFontAttributeName value:newFontSize range:NSMakeRange(0, newString.length)];
        
        
        [self replaceTextViewAttributedTextInRange:selectedRange withAttributedText:newString];
        
        
    }
}

- (void)colorSelector:(ColorSelector *)colorSelector selectedColor:(UIColor *)color
{
    //文本被选中的范围
    //这个变量仅仅在记录撤销操作步骤时使用
    NSRange selectedRange = _textEditingView.selectedRange;
    
    
    if(selectedRange.length > 0)
    {
        
        
        //利用替换法，更新字体颜色
        NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:[_textEditingView.attributedText attributedSubstringFromRange:selectedRange]];
        
        [newString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, newString.length)];

        
        [self replaceTextViewAttributedTextInRange:selectedRange withAttributedText:newString];
        
        
    }

}

#pragma mark - 设置字号、颜色的实际操作
//实际上通过替换字符串实现
- (void)replaceTextViewAttributedTextInRange:(NSRange)range withAttributedText:(NSAttributedString *)attrText
{
    NSAttributedString *theString = [_textEditingView.attributedText attributedSubstringFromRange:range];
    
    //替换前注册逆操作，使得撤销、重做功能有效
    [[_textEditingView.undoManager prepareWithInvocationTarget:self] replaceTextViewAttributedTextInRange:range withAttributedText:theString];
    
    [_textEditingView replaceAttributedTextInRange:range withAttributedText:attrText];
    
    _textEditingView.selectedRange = range;
}


#pragma mark - 文本框代理方法
//在这里面实现防止键盘遮挡
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = textView.frame;
    frame.size.height -= 236;
    textView.frame = frame;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    CGRect frame = textView.frame;
    frame.size.height += 236;
    textView.frame = frame;
    
    return YES;
}


#pragma mark - 完成、取消按钮
//点击完成、取消按钮，其操作都交给代理去做
- (IBAction)saveCancelButtonPressed:(UIBarButtonItem*)saveCancelButton
{
    switch (saveCancelButton.tag)
    {
        case 400://完成按钮
            //执行完成代理方法
            if ([self.delegate respondsToSelector:@selector(textEditingControllerDidSaveEditing:)])
                [self.delegate textEditingControllerDidSaveEditing:self];
                
            break;
            
        case 401://取消按钮
            //执行取消代理方法
            if ([self.delegate respondsToSelector:@selector(textEditingControllerDidCancelEditing:)])
                [self.delegate textEditingControllerDidCancelEditing:self];
            
        default:
            break;
    }
}


#pragma mark - 重写本视图控制器text属性的getter
//实际上是返回文本框的文字
- (NSAttributedString *)attrText
{
    return _textEditingView.attributedText;
}


@end


