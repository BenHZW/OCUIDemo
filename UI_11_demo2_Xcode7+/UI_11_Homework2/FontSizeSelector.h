//
//  FontSizeSelector.h
//  备忘录
//
//  Created by CJJMac on 15-1-11.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 字号选择器

#pragma mark - 字号选择器代理方法
@class FontSizeSelector;
@protocol FontSizeSelectorDelegate<NSObject>

- (void)fontSizeSelector:(FontSizeSelector*)fontSizeSelector selectedSize:(NSUInteger)size;

@end


#pragma mark - 字号选择器主体
@interface FontSizeSelector:UIView

@property(nonatomic, weak)id<FontSizeSelectorDelegate>delegate;

- (id)initWithOrigin:(CGPoint)origin;

#pragma mark -这个按钮提供给外部使用
//点击这个按钮，弹出选择面板
@property(nonatomic, strong, readonly)UIBarButtonItem *showFontSizeSelectorButton;

@end






