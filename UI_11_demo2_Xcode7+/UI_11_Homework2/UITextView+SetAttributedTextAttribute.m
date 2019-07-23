//
//  UITextView+SetAttributedTextAttribute.m
//  UI_12_Homework
//
//  Created by CJJMac on 15/10/12.
//
//

#import "UITextView+SetAttributedTextAttribute.h"

@implementation UITextView (SetAttributedTextAttribute)

//UITextView的textStorage属性是一个NSMutableAttributedString的子类的对象
//可以直接修改textStorage属性，效果立刻在文本框生效

- (void)setAttributedTextFont:(UIFont *)font range:(NSRange)range
{
/*
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [text addAttribute:NSFontAttributeName value:font range:range];
    
    self.attributedText = text;
 */
    
    [self.textStorage addAttribute:NSFontAttributeName value:font range:range];
}

- (void)setAttributedTextColor:(UIColor *)color range:(NSRange)range
{
/*
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [text addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    self.attributedText = text;
 */
    [self.textStorage addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)replaceAttributedTextInRange:(NSRange)range withAttributedText:(NSAttributedString *)attrText
{
/*
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [text replaceCharactersInRange:range withAttributedString:attrText];
    
    self.attributedText = text;
 */
    [self.textStorage replaceCharactersInRange:range withAttributedString:attrText];
}

@end






