//
//  UITextView+SetAttributedTextAttribute.h
//  UI_12_Homework
//
//  Created by CJJMac on 15/10/12.
//
//

#import <UIKit/UIKit.h>

#pragma mark - TextView的类目
@interface UITextView (SetAttributedTextAttribute)

#pragma mark - 封装好的改字号、颜色的方法
- (void)setAttributedTextFont:(UIFont*)font range:(NSRange)range;
- (void)setAttributedTextColor:(UIColor*)color range:(NSRange)range;

#pragma mark - 封装好的替换文字方法
- (void)replaceAttributedTextInRange:(NSRange)range withAttributedText:(NSAttributedString*)attrText;

@end



